<?php

namespace App\Http\Controllers;

use App\Models\CartProduct;
use App\Models\Customer;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\OrderHistory;
use App\Models\OrderState;
use App\Models\PaidOrder;
use App\Models\Payment;
use App\OrderStatus;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use phpDocumentor\Reflection\Types\Parent_;
use Tymon\JWTAuth\Claims\Custom;

class OrderController extends ControllerCore
{
    public $query_fields = [
        "id" => [
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "id_employee" => [
            "foreign_key"=>'id_employee',
            "relation_table" => 'employee',
            "owner_key" => 'id',
            "field" => 'name',
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "id_customer" =>[
            "foreign_key"=>'id_customer',
            "relation_table" => 'customer',
            "owner_key" => 'id',
            "field" => 'full_name',
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "current_status" =>[
            "foreign_key"=>'current_status',
            "relation_table" => 'order_state',
            "owner_key" => 'id',
            "field" => 'name',
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "date_ship" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "note" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => false
        ],
        "reason" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => false
        ],
        "created_at" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "img" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => false
        ],
        "type" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "order_detail" =>[
            "foreign_key"=>'id',
            "relation_table" => 'order_detail',
            "owner_key" => 'id_order',
            "field" => 'id',
            "multi_join" => [
                "hair_type" => "id_hair_type",
                "hair_style" => "id_hair_style",
                "hair_size" => "id_hair_size",
                "hair_color" => "id_hair_color",
                "hair_draw" => "id_hair_draw",
            ],
            "single_join" => [
                "kg" => "kg",
                "price" => "price",
            ],
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "id_address" =>[
            "foreign_key"=>'id_address',
            "relation_table" => 'address',
            "owner_key" => 'id',
            "field" => 'id',
            "multi_join" => [
                "country" => "id_country",
            ],
            "value" => "",
            "sort_by" => null,
            "filter" => true
        ],
        "id_cart" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null,
            "filter" => false
        ],
    ];

    public function __construct(Request $request = null)
    {
        return parent::__construct($request, new Order());
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function OrderReportList(Request $request)
    {
        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
        $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime(config('remyhair.default_filter_time_from')));
        $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
        $from = new \DateTime($this->query_fields['from']);
        $to = new \DateTime($this->query_fields['to']);
        $this->query_fields['from'] = $from->setTime(07,0, 0)->format('Y-m-d H:i:s');
        $this->query_fields['to'] = $to->setTime(23,30, 59)->format('Y-m-d H:i:s');

        switch ($request->type){
            case 'stats':{
                $data = OrderDetail::reportStats($this->query_fields, $request->date_ship);
                break;
            }
            case 'summary':{
                $data = Order::reportsummary($this->query_fields, $request->date_ship);
                break;
            }
            case 'weft':{
                $data = OrderDetail::reportWeft($this->query_fields, $request->date_ship);
                break;
            }
            case 'product-type':{
                $data = OrderDetail::reportType($this->query_fields, $request->date_ship);
                break;
            }
            case 'product-size':{
                $data = OrderDetail::reportSize($this->query_fields, $request->date_ship);
                break;
            }
            case 'country':{
                $data = Order::reportCountry($this->query_fields, $request->date_ship);
                break;
            }
            case 'customer':{
                $data = Order::reportCustomer($this->query_fields, $request->date_ship);
                break;
            }
            case 'customer-balance':{
                $data = Order::reportCustomerBalance($this->query_fields, $request->date_ship);
                break;
            }
            case 'payment':{
                $data = Order::reportPaymentMethod($this->query_fields, $request->date_ship);
                break;
            }
            default: {
                $data = OrderDetail::reportClosure($this->query_fields, $request->date_ship);
                break;
            }
        }
        $data['filters'] = $this->query_fields;

        return Parent::response(true, 'successully', $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderList(Request $request)
    {
        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;

        $this->query_fields = [
            "id" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "saleman" => [
                "foreign_key"=>'id_employee',
                "relation_table" => 'employee',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "customer" => [
                "foreign_key"=>'id_customer',
                "relation_table" => 'customer',
                "owner_key" => 'id',
                "field" => 'full_name',
                "value" => "",
                "sort_by" => null
            ],
            "type" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null,
                "filter" => true
            ],
            "status" => [
                "foreign_key"=>'current_status',
                "relation_table" => 'order_state',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "payment" => [
                "foreign_key"=>'payment',
                "relation_table" => 'payment',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "total_paid" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "total_unpaid" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "created_at" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null,
                "filter" => true
            ],
            "id_cart" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null,
                "filter" => true
            ],

        ];

        $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime(config('remyhair.default_filter_time_from')));
        $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
        $from = new \DateTime($this->query_fields['from']);
        $to = new \DateTime($this->query_fields['to']);
        $this->query_fields['from'] = $from->setTime(07,0, 0)->format('Y-m-d H:i:s');
        $this->query_fields['to'] = $to->setTime(23,59, 59)->format('Y-m-d H:i:s');

        if(!empty($fields)){
            foreach ($fields as $field => $value) {
                if($field != 'from' && $field != 'to'){
                    $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                    $this->query_fields[$field]['value'] = $value['value'];
                    $this->query_fields[$field]['sort_by'] = $value['sort_by'];
                }
            }
        }

        return parent::renderList($request);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Request $request)
    {
        $order = $this->_model->where('id', isset($request->id) ? $request->id : null)
            ->with(['customer' => function($c){
                $c->withTrashed();
            }])
            ->with(['employee' => function($c){
                $c->withTrashed();
            }])
            ->with([ 'orderDetail', 'address'])->with(['paidOrder' => function($paid_order){
                $paid_order->with('payment');
            }])->first();
        $order = $order->toArray();
        $order['total_order'] =   number_format($order['total_paid'],2,".",",");
        $order['total_unpaid'] =   number_format($order['total_unpaid'],2,".",",");
        $order['sub_total'] = number_format($order['total_product'],2,".",",");

        return  self::response($order ? true : false, $order ? '' : 'no order found', $order);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function changeState(Request $request)
    {
        $status = false;
        $msg = 'failed';
        $data = array();

        if($this->cart->id){
            $data = array();
            $validator = \Validator::make($request->order, [
                'id' => 'required',
            ]);
            $order_erros = CartProduct::checkHairDataExsit($request->only([ 'id_state']));
            if($validator->fails() || !empty($order_erros)){
                $status = false;
                $data =  !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                if(!empty($order_erros)) $data = array_merge($data, $order_erros);
            }else {
               $order = Order::find($request->order['id']);
               if($order){
                $order->current_status = $request->order['id_state'];
                $order->save();
                OrderHistory::addOrderHistory($order, $order->employee);
                   $status = true;
                   $msg = 'successfully';
                   $order = $this->_model->where('id', isset($request->order['id']) ? $request->order['id'] : null)->with(['customer', 'employee', 'orderDetail', 'address', 'paidOrder'])->first();
                   $order = $order->toArray();
                   $order['total_order'] =   number_format($order['total_paid'],2,".",",");
                   $order['total_unpaid'] =   number_format($order['total_unpaid'],2,".",",");
                   $order['sub_total'] = number_format($order['total_product'],2,".",",");
                    $data = $order;
               }else{
                   $msg = 'order not found';
               }
            }
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function addPayment(Request $request)
    {
        $status = false;
        $msg = 'failed';
        $data = array();

        if($this->cart->id){
            $data = array();
            $validator = \Validator::make($request->order, [
                'id' => 'required',
                'new_paid' => 'required|array'
            ]);
            if($validator->fails()){
                $status = false;
                $data =  $validator->errors()->toArray();
            }else {
               $order = Order::find($request->order['id']);
               $payment = Payment::find($request->order['new_paid']['id_payment']);
                if($order && $payment){
                   PaidOrder::addPaid($order, $request->order['new_paid']['paid'], $payment);
                   $order->total_unpaid = $order->total_paid - $order->getTotalPaided();
                   $order->save();
                   $status = true;
                   $msg = 'successfully';
                   $order = $this->_model->where('id', isset($request->order['id']) ? $request->order['id'] : null)->with(['customer', 'employee', 'orderDetail', 'address', 'paidOrder'])->first();
                   $order = $order->toArray();
                   $order['total_order'] =   number_format($order['total_paid'],2,".",",");
                   $order['total_unpaid'] =   number_format($order['total_unpaid'],2,".",",");
                   $order['sub_total'] = number_format($order['total_product'],2,".",",");
                    $data = $order;
               }else{
                   $msg = 'order not found';
               }
            }
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function kanban(Request $request)
    {
        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;

        $this->query_fields = [
            "id" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "saleman" => [
                "foreign_key"=>'id_employee',
                "relation_table" => 'employee',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "customer" => [
                "foreign_key"=>'id_customer',
                "relation_table" => 'customer',
                "owner_key" => 'id',
                "field" => 'full_name',
                "value" => "",
                "sort_by" => null
            ],
            "status" => [
                "foreign_key"=>'current_status',
                "relation_table" => 'order_state',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "payment" => [
                "foreign_key"=>'payment',
                "relation_table" => 'payment',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "total_paid" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "total_unpaid" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "position" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "date_ship" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
        ];

        $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime(config('remyhair.default_filter_time_from')));
        $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
        $from = new \DateTime($this->query_fields['from']);
        $to = new \DateTime($this->query_fields['to']);
        $this->query_fields['from'] = $from->setTime(07,0, 0)->format('Y-m-d H:i:s');
        $this->query_fields['to'] = $to->setTime(23,59, 59)->format('Y-m-d H:i:s');

        if(!empty($fields)){
            foreach ($fields as $field => $value) {
                if($field != 'from' && $field != 'to'){
                    $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                    $this->query_fields[$field]['value'] = $value['value'];
                    $this->query_fields[$field]['sort_by'] = $value['sort_by'];
                }
            }
        }
        $states = OrderState::all();

        return parent::renderKanban($request, $states);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function changeStates(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();

        $validate = Validator::make($request->all() ,[
            'orders' => 'required|array',
        ]);

        if($validate->fails() ){
            $msg =$validate->errors()->toArray();
        }else{
            foreach ($request->orders as $order) {
                $o = Order::where('id', $order['id'])->first();
                if($o){
                    $o->current_status = $order['current_status'];
                    $o->position = $order['position'];
                    $o->save();
                    $o->orderDetail()->update([
                        'status'=> $order['current_status'],
                    ]);
                }
                array_push($data, $order);
            }
            $status = true;
            $msg = 'successfully';
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function removeState(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();

        $validate = Validator::make($request->all() ,[
            'id' => 'required',
        ]);

        if($validate->fails() ){
            $msg =$validate->errors()->toArray();
        }else{
            $state = OrderState::find($request->id);
            if($state){
                $orders = Order::where('current_status', $request->id)->get();
                $default_id_state = OrderState::where('id', '!=', $request->id)->first();
                foreach ($orders as $item) {
                    $item->current_status = $default_id_state->id;
                    $item->save();
                }
                $state->delete();
                $status = true;
            }
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateStates(Request $request )
    {

        $status = false;
        $msg = '';
        $data = array();

        $validate = Validator::make($request->all() ,[
            'states' => 'required|array',
        ]);

        if($validate->fails() ){
            $msg =$validate->errors()->toArray();
        }else{
            foreach ($request->states as $state) {
                if(isset($state['add']) && $state['add']){
                    $s = new OrderState();
                    $s->name = $state['name'];
                    $s->number = $state['number'];
                    $s->save();
                }else{
                    $s = OrderState::find($state['id']);
                    if($s){
                        $s->name = $state['name'];
                        $s->number = $state['number'];
                        $s->save();
                    }
                }
            }
            $status = true;
        }
        return self::response($status, $msg, $data);

    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request )
    {

        $status = false;
        $msg = '';
        $data = array();

        $validate = Validator::make($request->all() ,[
            'data' => 'required|array',
        ]);

        if($validate->fails() ){
            $msg =$validate->errors()->toArray();
        }else{
            $order = Order::where('id', $request->data['id'])->first();
            if($request->user->id_group == 1 || $request->user->id == $order->id_employee){
                $order->note = (isset($request->data['note'])) ? $request->data['note'] : $order->note;
                $order->reason = (isset($request->data['reason'])) ? $request->data['reason'] : $order->reason;
                $order->date_ship = (isset($request->data['date_ship'])) ? $request->data['date_ship'] : $order->date_ship;
                $order->save();
                $data = [
                   'id' => $order->id,
                   'reason' => $order->reason,
                   'note' => $order->note,
                   'date_ship' => $order->date_ship,
                ];
                $status = true;
            }else{
                $msg = 'access denided';
            }
        }
        return self::response($status, $msg, $data);

    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function editOrder(Request $request) {
        $data = $request->editData;
        $status = false;
        $msg = '';
        $order = Order::where('id', $data['data']['id_order'])->with('customer')->first();
        $order->note = $data['data']['note'];
        $order->reason = $data['data']['reason'];
        $order->date_ship = $data['data']['date_ship'];
        if ($data['data']['type'] == 'cancel') {
            $order->type = 1;
            if($order->total_unpaid){
                Customer::setCustomerBalance($order->customer->id, (float)$order->customer->customer_balance + (float)$order->total_unpaid);
            }
        } elseif ($data['data']['type'] == 'refund') {
            $order->type = 2;
        }
        if($order->save()) {
            $status = true;
            $msg = 'successfully';
            $order_detail = $this->_model->where('id', isset($order->id) ? $order->id : null)
                ->with(['customer' => function($c){
                    $c->withTrashed();
                }])
                ->with(['employee' => function($c){
                    $c->withTrashed();
                }])
                ->with([ 'orderDetail', 'address'])->with(['paidOrder' => function($paid_order){
                    $paid_order->with('payment');
                }])->first();
            $order_detail = $order_detail->toArray();
            $order_detail['total_order'] =   number_format($order_detail['total_paid'],2,".",",");
            $order_detail['total_unpaid'] =   number_format($order_detail['total_unpaid'],2,".",",");
            $order_detail['sub_total'] = number_format($order_detail['total_product'],2,".",",");
            $res_data = [
                'order'=> $order_detail
            ];
        }

        return self::response($status, $msg, $res_data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function archive(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validate = Validator::make($request->all() ,[
            'id' => 'required',
        ]);
        if($validate->fails()){
            $msg = $validate->errors()->toArray();
        }else{
            $order = Order::where('id', $request->id)->first();
            if($order && ($order->id_employee == $request->user->id || $request->user->id_group == 1)){
                $order->archive = 1;
                $order->save();
                $status = true ;
                $msg = "Archive successfully";
                $data = [];
            }else{
                $status = false ;
                $msg = "Archive unsuccessfully";
            }
        }
        return self::response($status, $msg, $data);
    }

    public function updatePaidOrder(Request $request)
    {
        $status = false;
        $data = array();
        $msg = '';
        $validate = Validator::make($request->all() ,[
            'id_order' => 'required',
            'new_paid' => 'required',
            'id_payment' => 'required'
        ]);
        if($validate->fails()){
            $msg = $validate->errors()->toArray();
        }else{
            $order = Order::where('id', $request->id_order)->with('customer')->first();
            $payment = Payment::where('id', $request->id_payment)->first();
            if($order && ($order->id_employee == $request->user->id || $request->user->id_group == 1) && $payment && (float)$request->new_paid){
                PaidOrder::addPaid($order, (float)$request->new_paid, $payment);
                $customer_balance = $order->customer->customer_balance + $request->new_paid;
                Customer::setCustomerBalance($order->id_customer, $customer_balance);
                $order->total_unpaid = $order->total_unpaid - (float)$request->new_paid;
                $order->save();
                $status = true;
            }else{
                $status = false ;
                $msg = "Archive unsuccessfully";
            }
        }
        return self::response($status, $msg, $data);
    }
}
