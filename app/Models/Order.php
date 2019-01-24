<?php

namespace App\Models;

use Illuminate\Support\Facades\File;
use App\Models\OrderState;
use Illuminate\Database\Eloquent\Model;

class Order extends ModelCore
{
    protected $table = 'order';

    public function orderStatus(){
        return $this->belongsTo('App\Models\OrderState' ,'current_status');
    }


    public function orderPayments() {
        return $this->hasMany('App\Models\OrderPayment', 'id_order');
    }

    public function employee() {
        return $this->belongsTo('App\Models\Employee', 'id_employee');
    }

    public function orderDetail(){
        return $this->hasMany('App\Models\OrderDetail', 'id_order');
    }

    public function customer(){
        return $this->belongsTo('App\Models\Customer', 'id_customer');
    }

    public function address(){
        return $this->belongsTo('App\Models\Address', 'id_address');
    }

    public function paymentMethod(){
        return $this->belongsTo('App\Models\Payment', 'payment');
    }

    public function orderHistorys() {
        return $this->hasOne('App\Models\OrderHistory', 'id_order');
    }

    public function cart() {
        return $this->hasOne('App\Models\Cart', 'id_cart');
    }

    public function paidOrder()
    {
        return $this->hasMany('App\Models\PaidOrder', 'id_order');
    }

    /**
     * @param $id_cart
     * @param $id_customer
     * @param $id_employee
     * @param $id_address
     * @param $id_carrier
     * @param $payment
     * @param $date_ship
     * @param $note
     * @param $reason
     * @param $id_state
     * @param $paid
     * @return Order|array|string
     */
    public static function validateOrder($id_cart, $id_customer, $id_employee, $id_address, $id_carrier, $id_payment, $date_ship, $note, $reason, $id_state, $payment_fee, $paid, $balance, $editing_order = null)
    {
        $errors = [];
        if($editing_order){
            $order = Order::where('id', $editing_order['id'])->first();
            if($order){
                OrderDetail::clearByIdEditingOrder($order->id);
            }
        }else{
            $order = new Order();
        }
        $cart = Cart::find($id_cart);
        $customer = Customer::find($id_customer);
        $employee = Employee::find($id_employee);
        $address = Address::find($id_address);
        $carrier = Carrier::find($id_carrier);
        $payment = Payment::find($id_payment);
        $state = OrderState::find($id_state);

        if(!$cart){
            $errors['cart'] = 'cart not found';
        }
        if(!$customer){
            $errors['customer'] = 'customer not found';
        }
        if(!$employee){
            $errors['employee'] = 'employee not found';
        }
        if(!$address){
            $errors['id_address'] = 'address not found';
        }
        if(!$carrier){
            $errors['id_carrier'] = 'carrier not found';
        }
        if(!$payment){
            $errors['id_payment'] = 'payment not found';
        }
        if(!$state){
            $errors['status'] = 'status not found';
        }
        if(empty($errors)){
            try{
                $order->id_cart = $cart->id;
                $order->id_customer = $customer->id;
                $order->id_employee = $employee->id;
                $order->id_address = $address->id;
                $order->id_carrier = $carrier->id;
                $order->payment = $payment->id;
                $order->note = $note;
                $order->reason = $reason;
                $order->date_ship = $date_ship;
                $order->total_discount = $cart->discount;
                $order->total_shipping = $cart->shipping_cost;
                $order->total_product = $cart->getTotalProducts();
                $order->total_payment_fee = $cart->getTotalPaymentFee();
                $order->current_status = $state->id;
                $order->total_paid = (float)$order->total_product + (float)$order->total_shipping -  (float)$order->total_discount;
                $order->total_paid += $order->total_paid * ($payment_fee /100);
                if($editing_order){
                    $customer_balance = $customer->customer_balance + $editing_order['total_paid'] - $order->total_paid + $paid + $balance;
                    $order->total_unpaid = $order->total_unpaid - ( $editing_order['total_paid'] - $order->total_paid + $paid + $balance) ;
                }else{
                    $customer_balance = ($customer->customer_balance - $balance) + ($balance + $paid) - $order->total_paid;
                    $order->total_unpaid = ($order->total_paid - $paid - $balance) > 0 ? $order->total_paid - $paid - $balance : 0;
                }
                Customer::setCustomerBalance($order->id_customer, $customer_balance);
                if($order->save()){
                    $customer->status = 'Ordered';
                    $customer->save();
                }
                PaidOrder::addPaid($order, $paid + $balance, $payment);
                OrderPayment::addOrderPayment($order, $payment);
                OrderDetail::addOrderDetail($order, $cart, $state->id);
                OrderHistory::addOrderHistory($order, $employee);
                return $order;
            }catch (\Exception $e){
                return 'Something went wrong';
            }
        }
        return $errors;

    }

    /**
     * @param $image
     * @param null $domain
     * @return $this
     */
    public function addImg($image, $domain = null)
    {
        $image_str = explode(',', $image);
        $image = $image_str[1];
        $imageName = str_random(10).'.'.'png';
        File::put(public_path(). '/img/' . $imageName, base64_decode($image));
        $this->img = $domain. '/public/img/' . $imageName;
        $this->save();
        return $this;
    }

    /**
     * @return mixed
     */
    public function getTotalOrder()
    {
        $total_order = $this->getSubTotal() - $this->total_shipping - $this->total_discount;
        return $total_order;
    }

    public function getSubTotal()
    {
        return $this->total_product;
    }

    public function getOrderDetails()
    {
        return $this->orderDetail;
    }

    /**
     * @return int
     */
    public function getTotalPaided()
    {
        $paids = $this->paidOrder;
        $paid = 0;
        foreach ($paids as $item) {
            $paid += $item->paid;
        }

        return $paid;
    }

    /**
     * @return int
     */
    public function getTotalKg()
    {
        $oder_details = $this->orderDetail()->get();
        $kg = 0;
        foreach ($oder_details as $oder_detail) {
            $kg += $oder_detail->kg;
        }

        return $kg;
    }

    /**
     * @param array $fields
     * @return array
     */
    public function buildQuery(array $fields = [], $employee = null)
    {
        $query = $this;
        $relations = [];
        $main_fields = [];
        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to') {
                if ($data['relation_table']) {
                    array_push($main_fields, $this->table . '.' . $data['foreign_key']);
                    array_push($main_fields, $data['relation_table'] . '.' . $data['field'] . ' AS ' . $field);
                    array_push($relations, $this->table . '.' . $data['relation_table']);
                } else {
                    array_push($main_fields, $this->table . '.' . $field);
                }
            }
        }
        $query = $query->select($main_fields);

        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to') {
                if ($data['relation_table']) {
                    $query = $query->where($data['relation_table'] . '.' . $data['field'], 'like', $data['value'] . '%');
                    $query = $query->join($data['relation_table'], $this->table . '.' . $data['foreign_key'], '=', $data['relation_table'] . '.id');
                    if ($data['sort_by'] != 'none' && $data['sort_by']) {
                        $query = $query->orderBy($data['relation_table'] . '.' . $data['field'], $data['sort_by']);
                    }
                } else {
                    $query = $query->where($this->table . '.' . $field, 'like', $data['value'] . '%');
                    if ($data['sort_by'] != 'none' && $data['sort_by']) {
                        $query = $query->orderBy($field, $data['sort_by']);
                    }
                }
            }
        }
        if(isset($fields['from']) && isset($fields['to'])){
            $query = $query->whereBetween($this->table.'.created_at', [$fields['from'], $fields['to']]);
        }
        if($employee->id_group != 1){
            $query = $query->where($this->table.'.id_employee', $employee->id);
        }
        $query = $query->where($this->table . '.archive', '0');
        return ['relations' => $relations, 'query' => $query];
    }

    /**
     * @param $request
     * @param bool $date_ship
     * @return mixed
     */
    public static function reportSummary($request, $date_ship = false)
    {
        $order = self::with(['employee' => function ($employee) {
            $employee->select('id', 'name');
        }])
            ->with(['customer'=> function($customer){
                $customer->select('id', 'full_name');
            }])
            ->with('address')
            ->with('orderStatus')
            ->with(['orderDetail' => function($order_detail){
                $order_detail->with('hair_size')
                    ->with('hair_type')
                    ->with('hair_style')
                    ->with('hair_color')
                    ->with('hair_draw');
            }]);
        if(isset($request['from']) && isset($request['to'])){
            $order = $date_ship ?
                    $order->whereBetween('date_ship', [$request['from'], $request['to']])
                : $order->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order = $order->where('type', 0);
        $data['items'] = $order->get();
        if(!empty($data['items'])){
            foreach ($data['items'] as $order) {
                $order['total_kg'] = $order->getTotalKg();
            }
        }
        return $data;
    }

    /**
     * @param $request
     * @param $date_ship
     * @return mixed
     */
    public static function reportCountry($request, $date_ship)
    {
        $order = self::select('id_address','id')
            ->with(['address' => function($address){
                $address->with('country');
            }]);
        if(isset($request['from']) && isset($request['to'])){
            $order = $date_ship ?
                    $order->whereBetween('date_ship', [$request['from'], $request['to']])
                : $order->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order = $order->where('type', 0);
        $items = $order->get();
        foreach ($items as &$item) {
            $item['total_kg'] = $item->getTotalKg();
        }
        $items = array_values($items->groupBy('address.id_country')->toArray());
        $data['items'] = [];
        foreach ($items as &$item) {
            $kg = 0;
            foreach ($item as $value) {
                $kg += $value['total_kg'];
            }
            array_push($data['items'], [
                'country' => $item['0']['address']['country'],
                'total_kg' => $kg,
            ]);
        }
        return $data;
    }

    /**
     * @param $request
     * @param $date_ship
     * @return mixed
     */
    public static function reportCustomer($request, $date_ship)
    {
        $order = self::select('id_customer','id', 'id_address')
            ->with(['customer' => function($customer){
                $customer->select('id', 'full_name');
            }])
            ->with(['address' => function($adress){
                $adress->with('country');
            }]);
        if(isset($request['from']) && isset($request['to'])){
            $order = $date_ship ?
                    $order->whereBetween('date_ship', [$request['from'], $request['to']])
                : $order->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order = $order->where('type', 0);
        $items = $order->get();
        foreach ($items as &$item) {
            $item['total_kg'] = $item->getTotalKg();
        }
        $items = array_values($items->groupBy('id_customer')->toArray());
        $data['items'] = [];
        foreach ($items as &$item) {
            $kg = 0;
            foreach ($item as $value) {
                $kg += $value['total_kg'];
            }
            array_push($data['items'], [
                'customer' => $item['0']['customer'],
                'address' => $item['0']['address'],
                'total_kg' => $kg,
            ]);
        }
        return $data;
    }

    /**
     * @param $request
     * @param $date_ship
     * @return mixed
     */
    public static function reportCustomerBalance($request, $date_ship)
    {
        $order = self::
            with(['customer' => function($customer){
                $customer->select('id', 'full_name','phone', 'email', 'customer_balance');
            }]);
        if(isset($request['from']) && isset($request['to'])){
            $order = $date_ship ?
                    $order->whereBetween('date_ship', [$request['from'], $request['to']])
                : $order->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order = $order->where('type', 0);
        $items = $order->get();
        foreach ($items as &$item) {
            $item['total_order'] = $item->getTotalOrder();
        }

        $items = array_values($items->groupBy('id_customer')->toArray());
        $data['items'] = [];
        foreach ($items as &$item) {
            $total_order = 0;
            $total_discount = 0;
            foreach ($item as $value) {
                $total_order += $value['total_order'];
                $total_discount += $value['total_discount'];
            }
            array_push($data['items'], [
                'customer' => $item['0']['customer'],
                'total_discount' => $total_discount,
                'total_order' => $total_order,
            ]);
        }
        return $data;
    }

    /**
     * @param $request
     * @param $date_ship
     * @return mixed
     */
    public static function reportPaymentMethod($request, $date_ship)
    {
        $order = self::
            with('paymentMethod');
        if(isset($request['from']) && isset($request['to'])){
            $order = $date_ship ?
                    $order->whereBetween('date_ship', [$request['from'], $request['to']])
                : $order->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order = $order->where('type', 0);
        $items = $order->get();
        foreach ($items as &$item) {
            $item['total_order'] = $item->getTotalOrder();
        }

        $items = array_values($items->groupBy('payment')->toArray());
        $data['items'] = [];
        foreach ($items as &$item) {
            $total_order = 0;
            foreach ($item as $value) {
                $total_order += $value['total_order'];
            }
            array_push($data['items'], [
                'payment' => $item['0']['payment_method'],
                'total_order' => $total_order,
            ]);
        }
        return $data;
    }

}
