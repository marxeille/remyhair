<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use Event;
use App\Events\HistoryEvent;
use App\Models\HairColor;
use App\Models\HairDraw;
use App\Models\HairSize;
use App\Models\HairStyle;
use App\Models\HairType;

class HairController extends Controller
{

    public $_model;
    public $query_fields = [];
    public $page_number = 1;
    protected $item_limit = 16;
    public $cart;
    protected $dayAgo = 30;

        /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderList(Request $request, $type)
    {
        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;

        $this->query_fields = [
            "id" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "name" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ]
        ];

        if(!empty($fields)){
            foreach ($fields as $field => $value) {
                $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                $this->query_fields[$field]['value'] = $value['value'];
                $this->query_fields[$field]['sort_by'] = $value['sort_by'];
            }
        }

        return $this->getData($request, $type);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getData(Request $request, $type)
    {
        $class_name = 'App\Models\Hair'.ucfirst($type);
        if (!class_exists($class_name)) {
            // Can not find class
            abort(500, `Can not find class: {$class_name}`);
        }
        $this->_model = new $class_name;
        $data = [];
        $status = true;
        $message = 'successfully';
        try{
            $queryInfo = $this->_model->buildQuery($this->query_fields);
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
     * @param type
     * @return \Illuminate\Http\JsonResponse
     */
    public function add(Request $request, $type)
    {
        $status = false;
        $msg = '';
        $data = array();
        $table = 'hair_'.str_replace('-', '_', $type);
        
        $class_name = 'App\Models\Hair'.ucfirst($type);
        $current_employee = $request->user;
        if (!class_exists($class_name)) {
            // Can not find class
            abort(500, `Can not find class: {$class_name}`);
        }
        $validate = Validator::make($request->all() ,[
            'name' => 'required|unique:'.$table.',name',
        ]);
        if($validate->fails()){
            $msg = $validate->errors()->toArray();
        }else{
            $hair = new $class_name;
            $hair->name = $request->name;
            if ($request->export_type != '') {
                $hair->export_type = $request->export_type;
            }
            if ($type == 'style') {
                $hair->id_color = json_encode($request->colors); 
                $hair->export = (int) $request->export; 
            }
            $hair->save();
            if ($hair) {
                Event::fire(new HistoryEvent($current_employee->id, $hair->id, $request->path(), serialize($request->all()), $current_employee->name));
            }
            if ($type == 'type') {
                $hair->updateHairStyleRelation($request->styles);
            } 
            $status = true ;
            $msg = "Add successfully";
            $data = [
                $type => $hair
            ];
        }
        return $this->response($status, $msg, $data);
    }


    /**
     * Converts type into a class string.
     *
     * @param string
     *
     * @return string
     */
    protected function getClassFromType($type)
    {
        return '\\App\\Models\\'.str_replace('-', '', ucwords($type, '-'));
    }


     /**
     * @param Request $request
     * @param type
     * @return \Illuminate\Http\JsonResponse
     */

    public function edit(Request $request, $type)
    {
        $status = false;
        $msg = '';
        $data = array();
        $table = 'hair_'.str_replace('-', '_', $type);
        $class_name = 'App\Models\Hair'.ucfirst($type);
        if (!class_exists($class_name)) {
            // Can not find class
            abort(500, `Can not find class: {$class_name}`);
        }
        $validate = Validator::make($request->all() ,[
            'name' => 'required|unique:'.$table.',name,'.$request->id,
        ]);
        if($validate->fails()){
            $msg = $validate->errors()->toArray();
        }else{
            $hair = new $class_name;
            $hair = $hair::find(isset($request->id) ? $request->id : null);
            if($hair){
                $hair->name = $request->name;
                if ($request->export_type != '') {
                    $hair->export_type = $request->export_type;
                }
                if ($type == 'style') {
                    $hair->id_color = json_encode($request->id_color);
                    $hair->export = (int) $request->export; 
                } 
                if ($type == 'type') {
                    $hair->updateHairStyleRelation($request->id_style);
                } 
                $hair->save();
                $msg = "Update successfully";
                $data = [
                    'hair' => $hair
                ];
                $status = true;
            }else{
                $msg = "something went wrong";
            }

        }
        return $this->response($status, $msg, $data);
    }


    /**
     * @param id
     * @param type
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete($type, $id){
        $status = false;
        $msg = '';
        $class_path = 'App\Models\Hair'.ucfirst($type);
        if (!class_exists($class_path)) {
            // Can not find class
            abort(500, `Can not find class: {$class_path}`);
        }
        $hair = $class_path::find($id);
        if($hair){
            $hair->delete();
            $status = true;
            $msg = "Deleted successfully";
            $data = [
                'hair' => $hair
            ];
        }else{
            $msg = "something went wrong";
        }
        return $this->response($status, $msg, $data);
    }

    /**
     * @param $type
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function get($type, $id)
    {
        $class_path = 'App\Models\Hair'.ucfirst($type);
        if (!class_exists($class_path)) {
            // Can not find class
            abort(500, `Can not find class: {$class_path}`);
        }
        $hair = new $class_path;
        $hair = $hair->where('id', isset($id) ? $id : null)->first()->toArray();
        if ($type == 'style') {
            $hair['id_color'] = json_decode($hair['id_color'], true);
        } else {
            $hair['id_color'] = [];
        }
        if ($type == 'type') {
            $new_hair = $class_path::find($id);
            $hair['id_style'] = $new_hair->getHairStyleRelation()->pluck('id_hair_style')->all();
        } else {
            $hair['id_style'] = [];
        }
        return  $this->response($hair ? true : false, $hair ? '' : 'no hair found', $hair);
    }
}
