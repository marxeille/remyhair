<?php
/**
 * Created by PhpStorm.
 * User: TanNM
 * Date: 8/27/2018
 * Time: 4:27 PM
 */

namespace App\Http\Controllers;

use App\Models\Address;
use App\Models\Carrier;
use App\Models\Cart;
use App\Models\CartProduct;
use App\Models\Customer;
use App\Models\Employee;
use App\Models\HairColor;
use App\Models\HairDraw;
use App\Models\HairSize;
use App\Models\HairStyle;
use App\Models\HairType;
use App\Models\Order;
use App\Models\OrderState;
use App\Models\Payment;
use App\Models\ReportHairStyleType;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Routing\Route;

class CartController extends ControllerCore
{

    public static function create($id_employee, $id_carrier = null)
    {
        $cart = new Cart();
        $cart->id_employee = $id_employee;
        $cart->id_carrier = $id_carrier;
        $cart->save();

        return $cart;
    }

    /**
     * @param array $datas
     * @return array
     */
    private function checkDataExsit(array $datas)
    {
        $errors = [];
        if (!empty($datas)) {
            foreach ($datas as $key => $value) {
                switch ($key) {
                    case 'id_carrier':
                        {
                            if (!Carrier::find($value)) $errors['id_carrier'] = ['Invalid value'];
                            break;
                        }
                    case 'id_customer':
                        {
                            if (!Customer::find($value)) $errors['id_customer'] = ['Invalid value'];
                            break;
                        }
                    case 'id_employee':
                        {
                            if (!Employee::find($value)) $errors['id_employee'] = ['Invalid value'];
                            break;
                        }
                    case 'id_address':
                        {
                            if (!Address::find($value)) $errors['id_address'] = ['Invalid value'];
                            break;
                        }
                }
            }
        }
        return $errors;
    }

    /**
     * all carrier actions
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processCarrier(Request $request)
    {
        $status = false;
        $msg = 'falied';
        $data = array();

        switch ($request->sub_action){
            // remove carrier
            case 'remove':{
                $validator = \Validator::make($request->all(), [
                    'id_carrier' => 'required',
                ]);
                $check_exist = $this->checkDataExsit($request->only(['id_carrier']));
                if ($validator->fails() || !empty($check_exist)) {
                    $data = !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                    if (!empty($check_exist)) $data = array_merge($data, $check_exist);
                } else {
                    $this->cart->id_carrier = null;
                    $this->cart->save();
                    $data = CartController::getCartData($this->cart);
                    $msg = 'successfully';
                    $status = true;
                }
                break;
            }
            case 'add':
            // update carrier
            case 'update': {
                $validator = \Validator::make($request->all(), [
                    'id_carrier' => 'required',
                ]);
                $check_exist = $this->checkDataExsit($request->only(['id_carrier']));
                if ($validator->fails() || !empty($check_exist)) {
                    $data = !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                    if (!empty($check_exist)) $data = array_merge($data, $check_exist);
                } else {
                    $this->cart->id_carrier = $request->id_carrier;
                    $this->cart->save();
                    $data = CartController::getCartData($this->cart);
                    $msg = 'successfully';
                    $status = true;
                }

                break;
            }
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * all carrier actions
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processSaleman(Request $request)
    {
        $status = false;
        $msg = 'falied';
        $data = array();

        switch ($request->sub_action){
            case 'add':
            // update carrier
            case 'update': {
                $validator = \Validator::make($request->all(), [
                    'id_employee' => 'required',
                ]);
                $check_exist = $this->checkDataExsit($request->only(['id_employee']));
                if ($validator->fails() || !empty($check_exist)) {
                    $data = !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                    if (!empty($check_exist)) $data = array_merge($data, $check_exist);
                } else {
                    $this->cart->id_employee = $request->id_employee;
                    $this->cart->save();
                    $data = CartController::getCartData($this->cart);
                    $msg = 'successfully';
                    $status = true;
                }

                break;
            }
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * all address actions
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processAddress(Request $request)
    {
        $status = false;
        $msg = 'falied';
        $data = array();



        switch ($request->sub_action){
            // remove address
            case 'remove':{
                $check_exist = $this->checkDataExsit($request->only(['id_address']));
                if ( !empty($check_exist)) {
                    if (!empty($check_exist)) $data = array_merge($data, $check_exist);
                } else {
                    $this->cart->id_address = 0;
                    $this->cart->save();
                    $data = CartController::getCartData($this->cart);
                    $msg = 'successfully';
                    $status = true;
                }
                break;
            }
            case 'update':
                {
                $validator = \Validator::make($request->all(), [
                    'id_address' => 'required',
                ]);
                if ($validator->fails() ) {
                    $data =  $validator->errors()->toArray();
                } else {
                    $address = Address::find($request->id_address);
                    if($address){
                        $this->cart->id_address = $address->id;
                        $this->cart->save();
                        $data = CartController::getCartData($this->cart);
                        $msg = 'successfully';
                        $status = true;
                    }
                }
                break;
            }
            // update address
            case 'add':
                {
                $address = Address::saveAddresses(Customer::find($this->cart->id_customer), $request->all());
                if($address){
                    $this->cart->id_address = $address->id;
                    $this->cart->save();
                    $data = CartController::getCartData($this->cart);
                    $msg = 'successfully';
                    $status = true;
                }
                break;
            }
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processDiscount(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validator = \Validator::make($request->all(), [
            'discount' => 'required',
        ]);

        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        } else {
            $this->cart->discount = $request->discount;
            $this->cart->save();
            $data = CartController::getCartData($this->cart);
            $msg = 'successfully';
            $status = true;
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processPaymentFee(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validator = \Validator::make($request->all(), [
            'payment_fee' => 'required',
        ]);

        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        } else {
            $this->cart->payment_fee = $request->payment_fee;
            $this->cart->save();
            $data = CartController::getCartData($this->cart);
            $msg = 'successfully';
            $status = true;
        }

        return $this->response($status, $msg, $data);
    }


    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processCustomer(Request $request)
    {
        $status = false;
        $msg = 'falied';
        $data = array();

        switch ($request->sub_action){
            // remove customer
            case 'remove':{
                $check_exist = $this->checkDataExsit($request->only(['id_customer']));
                if (!empty($check_exist)) {
                    if (!empty($check_exist)) $data = array_merge($data, $check_exist);
                } else {
                    $this->cart->id_address = 0;
                    $this->cart->id_customer = 0;
                    $this->cart->save();
                    $data = CartController::getCartData($this->cart);
                    $data['cart']['customer'] = [];
                    $msg = 'successfully';
                    $status = true;
                }
                break;
            }

            // update customer
            case 'add': {
                $validator = \Validator::make($request->all(), [
                    'id_customer' => 'required',
                ]);
                $check_exist = $this->checkDataExsit($request->only(['id_customer']));
                if ($validator->fails() || !empty($check_exist)) {
                    $data = !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                    if (!empty($check_exist)) $data = array_merge($data, $check_exist);
                } else {
                    $customer = Customer::where('id', $request->id_customer )->with('address')->first();
                    if($customer) {
                        $this->cart->id_customer = $customer->id;
                        $this->cart->id_address = $customer->address->first()->id;
                        $this->cart->save();
                        $data = CartController::getCartData($this->cart);
                        $msg = 'successfully';
                        $status = true;
                    }
                }

                break;
            }
        }
        return $this->response($status, $msg, $data);
    }


    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processShipping(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validator = \Validator::make($request->all(), [
            'shipping_cost' => 'required',
        ]);

        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        } else {
                $this->cart->shipping_cost = $request->shipping_cost;
                $this->cart->save();
            $data = CartController::getCartData($this->cart);
            $msg = 'successfully';
                $status = true;
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function processProduct(Request $request){
        $status = false;
        $msg = 'falied';
        $data = array();

        switch ($request->sub_action){
            // remove customer
            case 'remove':{
                $validator = \Validator::make($request->all(), [
                    'id' => 'required',
                ]);
                if($validator->fails()){
                    $status = false;
                    $msg = 'failed';
                }else{
                    $product = CartProduct::where('id', $request->id)->first();
                    if($product){
                        $product->delete();
                        $data = CartController::getCartData($this->cart);
                        $msg = 'scucessfully';
                        $status = true;
                    }else{
                        $data['product'] = 'Product not found';
                    }
                }
                break;
            }

            // add product
            case 'add': {
                $validator = \Validator::make($request->all(), [
                    'kg' => 'required|numeric|min:0',
                    'price' => 'required|'.config('constant.validation.amount'),
                    'id_hair_size' => 'required|integer',
                    'id_hair_type' => 'required|integer',
                    'id_hair_color' => 'required|integer',
                    'id_hair_draw' => 'required|integer',
                    'id_hair_style' => 'required|integer',
                ]);

                $hair_errors = CartProduct::checkHairDataExsit($request->all());
                if($validator->fails() || !empty($hair_errors)){
                    $data =  !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                    if(!empty($hair_errors)) $data = array_merge($data, $hair_errors);
                }else{
                    if(empty($data)){
                        $this->cart->save();
                        $request['id_cart'] = $this->cart->id;
                        $input = $request->all();
                        $input['id_cart'] = $this->cart->id;
                        $product =  CartProduct::init($this->cart->id, $input);
                        $product->id_cart =  $this->cart->id;
                        $product->id_hair_size = $request->id_hair_size;
                        $product->id_hair_type = $request->id_hair_type;
                        $product->id_hair_color = $request->id_hair_color;
                        $product->id_hair_draw = $request->id_hair_draw;
                        $product->id_hair_style = $request->id_hair_style;
                        $product->kg = ($product->id) ? $product->kg + $request->kg : $request->kg;
                        $product->price = $request->price;
                        $product->total_price = $product->kg * $product->price;
                        $product->id ? $product->update() : $product->save();
                        $data = CartController::getCartData($this->cart);
                        $msg = 'scucessfully';
                        $status = true;
                    }
                }
                break;

            }
            // Import
            case 'import': {
                $products = $request->products;
                foreach ($products as $p) {
                    $validator = \Validator::make($p, [
                        'kg' => 'required|numeric|min:0',
                        'price' => 'required|'.config('constant.validation.amount'),
                        'id_hair_size' => 'required|integer',
                        'id_hair_type' => 'required|integer',
                        'id_hair_color' => 'required|integer',
                        'id_hair_draw' => 'required|integer',
                        'id_hair_style' => 'required|integer',
                    ]);

                    $hair_errors = CartProduct::checkHairDataExsit($p);
                    if($validator->fails() || !empty($hair_errors)){
                        $d =  !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                        if(!empty($hair_errors)) $d  = array_merge($d , $hair_errors);
                    }else{
                        if(empty($d)){
                            if(!$this->cart) $this->cart->save();
                            $request['id_cart'] = $this->cart->id;
                            $input = $request->all();
                            $input['id_cart'] = $this->cart->id;
                            $product =  CartProduct::init($this->cart->id, $p);
                            $product->id_cart =  $this->cart->id;
                            $product->id_hair_size = $p['id_hair_size'];
                            $product->id_hair_type = $p['id_hair_type'];
                            $product->id_hair_color = $p['id_hair_color'];
                            $product->id_hair_draw = $p['id_hair_draw'];
                            $product->id_hair_style = $p['id_hair_style'];
                            $product->kg = ($product->id) ? $product->kg + $p['kg'] : $p['kg'];
                            $product->price = $p['price'];
                            $product->total_price = $product->kg * $product->price;
                            $product->id ? $product->update() : $product->save();
                            $data = CartController::getCartData($this->cart);
                            $msg = 'scucessfully';
                            $status = true;
                        }
                    }
                }

                break;

            }

            // update product
            case 'update': {
                $validator = \Validator::make($request->all(), [
                    'id' => 'required',
                    'kg' => 'required|numeric|min:0',
                    'price' => 'required|numeric|min:0',
                    'id_hair_size' => 'required|integer',
                    'id_hair_type' => 'required|integer',
                    'id_hair_color' => 'required|integer',
                    'id_hair_draw' => 'required|integer',
                    'id_hair_style' => 'required|integer',
                ]);

                $hairs = $request->only(['id_hair_size', 'id_hair_type', 'id_hair_color', 'id_hair_draw', 'id_hair_style']);
                $hair_errors =CartProduct::checkHairDataExsit($hairs);
                if($validator->fails() || !empty($hair_errors)){
                    $status = false;
                    $data =  !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                    if(!empty($hair_errors)) $data = array_merge($data, $hair_errors);
                }else{
                    $product = CartProduct::where('id', $request->id)->first();
                    if($product){
                        $product->id_hair_size = $request->id_hair_size;
                        $product->id_hair_type = $request->id_hair_type;
                        $product->id_hair_color = $request->id_hair_color;
                        $product->id_hair_draw = $request->id_hair_draw;
                        $product->id_hair_style = $request->id_hair_style;
                        $product->kg = $request->kg;
                        $product->price = $request->price;
                        $product->total_price = $product->kg * $product->price;
                        $product->update();
                        $data = CartController::getCartData($this->cart);
                        $msg = 'scucessfully';
                        $status = true;
                    }else{
                        $data['product'] = 'Product not found';
                        $msg = 'falied';
                        $status = 'false';
                    }
                }
                break;

            }
        }

        return $this->response($status, $msg, $data);

    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function init(Request $request)
    {
        $status = true;
        $msg = '';
        $order = Order::where('id_cart', $this->cart->id)->where('type', 0)->with(['paidOrder'])->first();
        if($order){
            $order = $order->toArray();
            $order['total_order'] =   number_format($order['total_paid'],2,".",",");
            $order['total_unpaid'] =   number_format($order['total_unpaid'],2,".",",");
            $order['sub_total'] = number_format($order['total_product'],2,".",",");
        }
        $data = [
            'init_data' => [
                'carriers' => Carrier::getAll(),
                'payments' => Payment::getAll(),
                'hair_draws' => HairDraw::getAll(),
                'hair_sizes' => HairSize::getAll(),
                'hair_styles' => HairStyle::getAll(),
                'hair_types' => HairType::getAll(),
                'hair_colors' => HairColor::getAll(),
                'sale_men'=> Employee::getSaleMen(),
                'order_states' => OrderState::select('name', 'id')->get()
            ],
            'is_editing' => !empty($order),
            'order' => $order
        ];
        $data = array_merge($data, CartController::getCartData($this->cart));

        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function validateOrder(Request $request)
    {
        $status = false;
        $msg = 'failed';
        $data = array();
        if($this->cart->id){
            $data = array();
            $validator = \Validator::make($request->all(), [
                'id_payment' => 'required',
                'id_state' => 'required',
                'id_carrier' => 'required',
                'id_customer' => 'required',
                'id_employee' => 'required',
                'id_address' => 'required',
            ]);
            $order_erros = CartProduct::checkHairDataExsit($request->only(['id_payment', 'id_state', 'id_carrier', 'id_customer', 'id_employee', 'id_address']));
            if($validator->fails() || !empty($order_erros)){
                $status = false;
                $data =  !empty($validator->errors()) ? $validator->errors()->toArray() : [];
                if(!empty($order_erros)) $data = array_merge($data, $order_erros);
            }else {
                $id_payment = $request->id_payment;
                $note   = $request->note ? $request->note : null;
                $reason   = $request->reason ? $request->reason : null;
                $date_ship   = $request->date_ship;
                $paid = $request->paid;
                $id_state = $request->id_state;
                $order = Order::validateOrder($this->cart->id, $request->id_customer, $request->id_employee, $request->id_address, $request->id_carrier, $id_payment, $date_ship, $note, $reason, $id_state, $request->payment_fee, $paid, $request->balance, $request->editing_order);
                if($order->id){
                    if(isset($request->img) && $request->img) $order = $order->addImg($request->img, env('APP_URL'));
                    Employee::assginSaleCommisison($order, $request->id_employee);
                    $data = $order->toArray();
                    $status = true;
                    $msg = 'successfully';
                }
            }
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param $cart
     * @return mixed
     */
    public static function getCartData($cart)
    {
        $customer = $cart->customer()->where('id',  $cart->id_customer ? $cart->id_customer : 0)->with('address')->first();
        $data['cart'] = $cart;
        $data['cart']['customer'] = isset($customer) ?  $customer->toArray() : [];
        $data['cart']['address'] = $cart->address;
        $data['cart']['products'] = $cart->getCartProducts();
        $data['cart']['summary'] = $cart->getCartSummaryDetails();

        return $data;
    }
}
