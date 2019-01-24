<?php
/**
 * Created by PhpStorm.
 * User: SYSTEM
 * Date: 7/29/2018
 * Time: 9:25 AM
 */

namespace App\Http\Controllers;

use App\Models\Carrier;
use App\Models\Cart;
use App\Models\InvoiceStatus;
use App\Models\Order;
use App\Models\OrderState;
use App\Models\HairSize;
use App\Models\Employee;
use App\Models\Procedure;
use App\Models\WorkProfile;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class ControllerCore extends Controller
{
    public $query_fields = [];
    public $page_number = 1;
    public $_model;
    protected $item_limit = 30;
    public $cart;
    protected $dayAgo = 30;

    /**
     * ControllerCore constructor.
     * @param Request $request
     * @param null $model
     */
    public function __construct(Request $request, $model = null)
    {
        $this->middleware(function ($request, $next) use ($model) {
            if(isset($request->id_cart) && $request->id_cart){
                $this->cart =  Cart::find($request->id_cart);
                $order = Order::where('id_cart', $this->cart->id)->with(['paidOrder'])->first();
                if(($order && $order->type != 0) || !$this->cart){
                     $this->cart = new Cart();
                }
            }else{
                $this->cart = new Cart();
                $this->cart->id_employee = ($request->user) ? $request->user->id : null;
                $this->cart->id_carrier = (Carrier::first()) ? Carrier::first()->id : 0 ;
            }
            $this->cart->save();
            $this->_model = $model;
            return $next($request);
        });
    }

    /**
     * @param bool $status
     * @param string $message
     * @param array $data
     * @param int $code
     * @return \Illuminate\Http\JsonResponse
     */
    public function response($status = true, $message = '', $data = [], $code = 200)
    {
        $data = array_merge($data);
        return response()->json([
                'status' => $status,
                'message'=> $message,
                 'data' => $data
        ], $code);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderList(Request $request)
    {
        $data = [];
        $status = true;
        $message = 'successfully';
        try{
            $default_sort = array_filter($this->query_fields, function($q){
                return (isset($q['sort_by']) && $q['sort_by'] != null);
            });
            if(empty($default_sort) && !$this->_model instanceof InvoiceStatus){
                $this->query_fields['created_at'] = [
                    "relation_table" => null,
                    "value" => "",
                    "sort_by" => 'DESC'
                ];
            }
            $queryInfo = $this->_model->buildQuery($this->query_fields, (isset($request->user) ? $request->user : null));
            $total = $queryInfo['query']->count();
            $data['page_limit'] = ceil($total / $this->item_limit);
            $data['current_page'] = $this->page_number;
            $offset = ($this->page_number - 1)  * $this->item_limit;
            $data['items'] = $this->_model->getList($queryInfo['query'], $offset, $this->item_limit);
            $data['items_per_page'] = $this->item_limit;
            $data['total_items'] = $total;
            foreach ($this->query_fields as &$query_field) {
               if(isset($query_field['relation_table'])) unset($query_field['relation_table']);
               if(isset($query_field['foreign_key'])) unset($query_field['foreign_key']);
               if(isset($query_field['owner_key'])) unset($query_field['owner_key']);
               if(isset($query_field['field'])) unset($query_field['field']);
            }
            $data['filters'] = $this->query_fields;

        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return $this->response($status, $message, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderListById(Request $request)
    {
        $data = [];
        $status = true;
        $message = 'successfully';
        try{
            $employee = Employee::find($request->id_employee);
            $queryInfo = $this->_model->buildQueryById($this->query_fields, $employee);
            $total = $queryInfo['query']->count();
            $data['page_limit'] = ceil($total / $this->item_limit);
            $data['current_page'] = $this->page_number;
            $offset = ($this->page_number - 1)  * $this->item_limit;
            $data['items'] = $this->_model->getList($queryInfo['query'], $offset, $this->item_limit);
            $data['items_per_page'] = $this->item_limit;
            $data['total_items'] = $total;
            foreach ($this->query_fields as &$query_field) {
               if(isset($query_field['relation_table'])) unset($query_field['relation_table']);
               if(isset($query_field['foreign_key'])) unset($query_field['foreign_key']);
               if(isset($query_field['owner_key'])) unset($query_field['owner_key']);
               if(isset($query_field['field'])) unset($query_field['field']);
            }
            $data['filters'] = $this->query_fields;

        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return $this->response($status, $message, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderKanban(Request $request, $table = null)
    {
        $data = [];
        $status = true;
        $message = 'successfully';
        try{
            $queryInfo = $this->_model->buildQuery($this->query_fields, $request->user);
            $total = $queryInfo['query']->count();
            $data['page_limit'] = ceil($total / $this->item_limit);
            $data['current_page'] = $this->page_number;
            $data['items'] = $this->_model->getList($queryInfo['query']);
            $data['items_per_page'] = $this->item_limit;
            $data['total_items'] = $total;
            foreach ($this->query_fields as &$query_field) {
               if(isset($query_field['relation_table'])) unset($query_field['relation_table']);
               if(isset($query_field['foreign_key'])) unset($query_field['foreign_key']);
               if(isset($query_field['owner_key'])) unset($query_field['owner_key']);
               if(isset($query_field['field'])) unset($query_field['field']);
            }
            $data['filters'] = $this->query_fields;
            if($this->_model instanceof WorkProfile){
                $data['id_procedure'] = Procedure::where('title', $this->query_fields['id_procedure']['value'])->first()->id ;
            }
            $data['kanbanData'] = $table;
            if(count($data['items']) && $this->_model instanceof Order){
                foreach ($data['items'] as $key => $item) {
                    $kg = $item->getTotalKg();
                    $data['items'][$key]->kg = $kg;
                }
            }
        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return $this->response($status, $message, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function reportList(Request $request){
        $data = [];
        $status = true;
        $message = 'successfully';
        try{
            $default_sort = array_filter($this->query_fields, function($q){
                return (isset($q['sort_by']) && $q['sort_by'] != null);
            });
            if(empty($default_sort)){
                $this->query_fields['created_at'] = [
                    "relation_table" => null,
                    "value" => "",
                    "sort_by" => 'DESC'
                ];
            }
            $queryInfo = $this->_model->buildReportListQuery($this->query_fields);
            $total = $queryInfo['query']->count();
            $data['page_limit'] = ceil($total / $this->item_limit);
            $data['current_page'] = $this->page_number;
            $offset = ($this->page_number - 1)  * $this->item_limit;
            $data['items'] = $this->_model->getList($queryInfo['query'], $offset, $this->item_limit);
            $data['items_per_page'] = $this->item_limit;
            $data['total_items'] = $total;
            foreach ($this->query_fields as &$query_field) {
                if(isset($query_field['relation_table'])) unset($query_field['relation_table']);
                if(isset($query_field['foreign_key'])) unset($query_field['foreign_key']);
                if(isset($query_field['owner_key'])) unset($query_field['owner_key']);
                if(isset($query_field['field'])) unset($query_field['field']);
            }
            $data['filters'] = $this->query_fields;

        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return self::response($status, $message, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function OrderReportList(Request $request){
        $data = [];
        $status = true;
        $message = 'successfully';
        $dayAgo = 30;
        try{
            $queryInfo = $this->_model->buildOrderReportQuery($this->query_fields, (isset($request->dateShip)) ? $request->dateShip : false);
            $total = $queryInfo['query']->count();
            $data['page_limit'] = ceil($total / $this->item_limit);
            $data['current_page'] = $this->page_number;
            $offset = ($this->page_number - 1)  * $this->item_limit;
            $data['items'] = $this->_model->getList($queryInfo['query'], $offset, $this->item_limit);
            $data['items_per_page'] = $this->item_limit;
            $data['total_items'] = $total;
            foreach ($this->query_fields as &$query_field) {
                if(isset($query_field['relation_table'])) unset($query_field['relation_table']);
                if(isset($query_field['foreign_key'])) unset($query_field['foreign_key']);
                if(isset($query_field['owner_key'])) unset($query_field['owner_key']);
                if(isset($query_field['field'])) unset($query_field['field']);
            }
            $data['filters'] = $this->query_fields;
            $hair_size = [];
            $hair_data = HairSize::select('id', 'name')->get()->toArray();
            foreach ($hair_data as $key=>$value) {
                $hair_size[$value['id']] = $value['name'];
            }
            $order_status = array_map('current', OrderState::select('name')->get()->toArray());
            $statuses = [];
            $stats = $this->_model->getOrderStats($this->query_fields);
            
            foreach ($stats as $stat) {
                foreach($hair_size as $id_hair => $name) {
                    if($stat->id == $id_hair) {
                        $statuses[$id_hair][] = $stat->name;
                    }
                }    
            }
            foreach($statuses as $key=>$filter) {
                $diff = array_diff($order_status, $filter);
                foreach($diff as $diff_status) {
                    $value = (object) ['id'=>$key, 'name'=> $hair_size[$key], 'kg'=>0, 'status'=> $diff_status];
                    array_push($stats, $value);
                }
            }
           
            $stats_by_name = [];
            $stats_by_id = [];
            
            foreach($stats as $stat){
                if(!isset($stats_by_id[$stat->id])){
                   $stats_by_id[$stat->id] = $stat;
                }
             }
            foreach($stats_by_id as $id) {
                $stats_by_name[$id->id]['name'] = $id->name; 
                foreach($stats as $stat) {
                    if ($id->id == $stat->id) {
                        $stats_by_name[$id->id]['status'][] = ['kg' => $stat->kg, 'status' => $stat->name]; 
                    }
                }
            }

            foreach($stats_by_name as &$value) {
                usort($value['status'], function ($a, $b) use ($order_status) {
                    $pos_a = array_search($a['status'], $order_status);
                    $pos_b = array_search($b['status'], $order_status);
                    return $pos_a - $pos_b;
                });

                $value['status'][] = ['kg'=>''];
            }
     
            $total_status = [];
            $total_stats = $this->_model->getOrderStats($this->query_fields, false);
            foreach($total_stats as $t_value)  {
                array_push($total_status, (array) $t_value);
            }
            $total = ['name'=>'Total','status'=>$total_status];
            $status_diff = array_diff($order_status, array_map('current',$total['status']));
            foreach($status_diff as $fill_status) {
                $total['status'][] = ['kg'=>0, 'status'=>$fill_status];
            }
            $total['status'][] = (object) $this->_model->getOrderTotalKg($this->query_fields)[0];
            $stats_by_name[] = $total;
            $data['items']['stats']  = collect($stats_by_name);
        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return self::response($status, $message, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function exportOrderList(Request $request){
        $data = [];
        $status = true;
        $message = 'successfully';
        $dayAgo = 30;

        try{
            $queryInfo = $this->_model->buildOrderReportQuery($this->query_fields);
            $total = $queryInfo['query']->count();
            $data['items'] = array_values($this->_model->getList($queryInfo['query'], 0, $total)->toArray());
            foreach ($data['items'] as &$item){
                $item = array_values($item);
            }
            $data['total_items'] = $total;

        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return self::response($status, $message, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function exportList(Request $request){
        $data = [];
        $status = true;
        $message = 'successfully';
        $dayAgo = 30;

        try{
            $queryInfo = $this->_model->buildReportListQuery($this->query_fields);
            $total = $queryInfo['query']->count();
            $data['items'] = array_values($this->_model->getList($queryInfo['query'], 0, $total)->toArray());
            foreach ($data['items'] as &$item){
                $item = array_values($item);
            }
            $data['total_items'] = $total;

        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return self::response($status, $message, $data);
    }
}
