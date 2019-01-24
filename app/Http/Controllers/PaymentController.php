<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Employee;
use App\Models\InvoiceStatus;
use App\Models\Note;
use App\Models\Order;
use App\Models\Payment;
use App\Models\Support;
use Illuminate\Http\Request;
use DB;
use Event;
use App\Events\HistoryEvent;
use Illuminate\Support\Facades\Validator;

class PaymentController extends ControllerCore
{
    public function __construct(Request $request = null)
    {
        return parent::__construct($request, new Payment());
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
            "name" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
        ];
        if(!empty($fields)){
            foreach ($fields as $field => $value) {
                $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                $this->query_fields[$field]['value'] = $value['value'];
                $this->query_fields[$field]['sort_by'] = $value['sort_by'];
            }
        }
        return parent::renderList($request);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function add(Request $request)
    {
        $status = true;
        $msg = 'successfully';
        $data = array();
        $current_employee = $request->user;
        $validator = \Validator::make($request->all(), [
            'name' => 'required|unique:payment',
        ]);
        if($validator->fails()){
            $status = false;
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        }else{
            $data = new Payment();
            $data->name = $request->name;
            $data->payment_fee = (float)$request->fee;
            $data->save();
            if ($data) {
                Event::fire(new HistoryEvent($current_employee->id, $data->id, $request->path(), serialize($request->all()), $current_employee->name));
            }
        }
        return $this->response($status, $msg, ['payment' => $data]);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit(Request $request )
    {
        $status = true;
        $msg = '';
        $data = array();
        $payment = Payment::find(isset($request->id) ? $request->id : null);
        if($payment){
            $validator = \Validator::make($request->all(), [
                'name' => 'required|unique:payment,name,' . $payment->name,
            ]);
            if($validator->fails() && $payment->name != $request->name){
                $status = false;
                $data = $validator->errors()->toArray();
                $msg = 'failed';
            }else{
                $payment->name = $request->name;
                $payment->payment_fee = (float)$request->payment_fee;
                $payment->save();
            }
        }else{
            $status = false;
            $msg = 'failed';
            $data['id_payment'] = 'Payment does not exist';
        }

        return $this->response($status, $msg,$payment ? $payment->toArray() : $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Request $request)
    {
        $data = $this->_model->where('id', isset($request->id) ? $request->id : null)->first();

        return  self::response($data ? true : false, $data ? '' : 'no '.$data.' found', $data->toArray());
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function detail(Request $request){
        $support = Support::where('id', isset($request->id) ? $request->id : null)->first();
        $support['employee'] = $support->employee;
        $support['customer'] = $support->customer;
        $support['notes'] = $support->notes;
        $support['invoice_status'] = $support->invoice_status;
        $data = array(
            'support' => $support,
        );
        return self::response($data ? true : false, $data ? 'successfully' : 'no support found', $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete(Request $request)
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
            $payment = Payment::find($request->id);

            if($payment){
                $orders = Order::where('payment', $payment->id)->get();
                $default_payment = Payment::where('id', '!=', $request->id)->first();
                foreach ($orders as $item) {
                    $item->payment = $default_payment->id;
                    $item->save();
                }
                $payment->delete();
                $status = true;
            }
        }
        return self::response($status, $msg, $data);
    }
}
