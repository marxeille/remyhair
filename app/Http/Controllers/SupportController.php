<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Employee;
use App\Models\InvoiceStatus;
use App\Models\Note;
use App\Models\Complain;
use App\Models\Payment;
use App\Models\Support;
use Event;
use App\Events\HistoryEvent;
use Illuminate\Http\Request;
use DB;

class SupportController extends ControllerCore
{
    public function __construct(Request $request = null)
    {
        return parent::__construct($request, new Support());
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
                "ignore" => false,
                "sort_by" => null
            ],
            "employee_name" => [
                "foreign_key"=>'id_employee',
                "relation_table" => 'employee',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "ignore" => false,
                "sort_by" => null
            ],
            "customer_name" =>[
                "foreign_key"=>'id_customer',
                "relation_table" => 'customer',
                "owner_key" => 'id',
                "field" => 'full_name',
                "value" => "",
                "ignore" => false,
                "sort_by" => null
            ],
            "invoice_status" => [
                "foreign_key"=>'id_invoice_status',
                "relation_table" => 'invoice_status',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "ignore" => false,
                "sort_by" => null
            ],
            "note" => [
                "foreign_key"=>'id',
                "relation_table" => 'note',
                "owner_key" => 'id_support',
                "field" => 'content',
                "value" => "",
                "group_concat" => true,
                "ignore" => false,
                "join" => "left",
                "sort_by" => null
            ],
            "support_time" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null,
                "ignore" => false,
                "special_field" => "updated_at"
            ],
            "customer_type" =>[
                "foreign_key"=>'id_customer',
                "relation_table" => 'customer',
                "owner_key" => 'id',
                "field" => 'type',
                "value" => "",
                "sort_by" => null,
                "ignore" => false,
                "relation_data" => true,
            ],
            "status" =>[
                "relation_table" => null,
                "value" => "",
                "ignore" => false,
                "sort_by" => null
            ],
            "complain" =>[
                "relation_table" => null,
                "value" => "",
                "ignore" => true,
                "sort_by" => null
            ],
            "updated_at" =>[
                "relation_table" => null,
                "value" => "",
                "ignore" => false,
                "sort_by" => null
            ],
            "created_at" => [
                "relation_table" => null,
                "value" => "",
                "ignore" => false,
                "sort_by" => null
            ],
        ];
        $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime(config('remyhair.default_filter_time_from')));
        $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
        $from = new \DateTime($this->query_fields['from']);
        $to = new \DateTime($this->query_fields['to']);
        $this->query_fields['from'] = $from->setTime(07,00,0)->format('Y-m-d H:i:s');
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
    public function add(Request $request)
    {
        $status = true;
        $msg = 'successfully';
        $data = array();
        $current_employee = $request->user;
        $validator = \Validator::make($request->all(), [
            'invoice_number' => 'numeric|nullable',
        ]);
        if($validator->fails()){
            $status = false;
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        }else{
            $employee = Employee::find(isset($request->id_employee) ? $request->id_employee : null);
            $customer = Customer::find(isset($request->id_customer) ? $request->id_customer : null);
            $invoice_status = InvoiceStatus::find(isset($request->id_invoice_status) ? $request->id_invoice_status : null);
            if($employee && $customer){
                if(!$invoice_status && isset($request->id_invoice_status)) {
                    $status = false;
                    $data['id_invoice_status'] = 'Invoice status does not exist';
                }
                
                if($status){
                    $support = new Support([
                        'id_customer' => $customer->id,
                        'id_employee' => $employee->id,
                        'id_invoice_status' => ($invoice_status) ? $invoice_status->id : null ,
                        'invoice_number' => (isset($request->invoice_number) && ($invoice_status)) ? (int)$request->invoice_number : 0,
                        'source' => isset($request->source) ? $request->source : ' ',
                        'status' => isset($request->source) ? $request->status : ' ',
                    ]);
                    if($support->save()){
                        $customer->status = 'Supporting';
                        $customer->save();
                        Event::fire(new HistoryEvent($current_employee->id, $support->id, $request->path(), serialize($request->all()), $current_employee->name));
                    }
                    if(isset($request->notes)){
                        foreach ($request->notes as $item) {
                            $node = new Note();
                            $node->id_support = $support->id;
                            $node->content = $item;
                            $node->save();
                        }
                    }
                    if(isset($request->complains)){
                        foreach ($request->complains as $item) {
                            $complain = new Complain();
                            $complain->id_support = $support->id;
                            $complain->content = $item;
                            $complain->save();
                        }
                    }
                }
            }else{
                $status = false;
                $msg = 'failed';
                if(!$employee) $data['id_employee'] = 'Employee does not exist';
                if(!$customer) $data['id_customer'] = 'Customer does not exist';
            }
        }
        return $this->response($status, $msg, $data);
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
        $support = Support::find(isset($request->id) ? $request->id : null);
        if($support){
            $invoice_status = InvoiceStatus::find(isset($request->id_invoice_status) ? $request->id_invoice_status : null);
            if(!$invoice_status && isset($request->id_invoice_status)) {
                $status = false;
                $data['id_invoice_status'] = 'Invoice status does not exist';
            }
        
            if($status){
                $support->id_invoice_status =  ($invoice_status) ? $invoice_status->id : $support->id_invoice_status;
                $support->support_time =  isset($request->support_time) ? (float)$request->support_time :  $support->support_time;
                $support->source = isset($request->source) ? $request->source : $support->source;
                $support->status = isset($request->status) ? $request->status : $support->status;
                $support->invoice_number =  (isset($request->invoice_number) && ($invoice_status)) ? (int)$request->invoice_number : $support->invoice_number;
                $support->updated_at = date('Y-m-d H:i:s');
                $support->save();
                if(isset($request->notes)){
                    foreach ($request->notes as $item) {
                        if(isset($item['content']) && $item['id']){
                            $node = Note::find($item['id']);
                            if($node){
                                $node->content = $item['content'];
                                $node->save();
                            }
                        }else{
                            if($item['content']){
                            $node = new Note();
                            $node->id_support = $request->id;
                            $node->content = $item['content'];
                            $node->save();
                        }
                    }
                }
                }
                if(isset($request->complains)){
                    foreach ($request->complains as $item) {
                        if(isset($item['content']) && $item['id']){
                            $complain = Complain::find($item['id']);
                            if($complain){
                                $complain->content = $item['content'];
                                $complain->save();
                            }
                        }else{
                            if($item['content']){
                            $complain = new Complain();
                            $complain->id_support = $request->id;
                            $complain->content = $item['content'];
                            $complain->save();
                        }
                    }
                }
            }
            }
        }else{
            $status = false;
            $msg = 'failed';
            $data['id_support'] = 'Support does not exist';
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderListById(Request $request)
    {
        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
        $this->query_fields = [
            "id" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "employee_name" => [
                "foreign_key"=>'id_employee',
                "relation_table" => 'employee',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "customer_name" =>[
                "foreign_key"=>'id_customer',
                "relation_table" => 'customer',
                "owner_key" => 'id',
                "field" => 'full_name',
                "value" => "",
                "sort_by" => null
            ],
            "invoice_status" => [
                "foreign_key"=>'id_invoice_status',
                "relation_table" => 'invoice_status',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "support_time" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "status" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "updated_at" =>[
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

        return parent::renderListById($request);
    }


     /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $key_word = preg_replace('/[^A-Za-z0-9\-]/', '', isset($request->key_word) ? $request->key_word : null);
        if(!empty($key_word)){
            $customer = Customer::search($key_word);
            $number_customer = count($customer);
            $status = $customer ? true : false ;
            $data = [
                'customer' => $customer,
            ];
            $msg = $status ? 'find '.$number_customer.' record.' : 'record not found.' ;
        }
        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Request $request)
    {
        $support = $this->_model->where('id', isset($request->id) ? $request->id : null)->first();
        $support['notes'] = $support->notes;
        $support['customer'] = $support->customer;
        $support->complains;
        $data = array(
            'support' => $support,
        );
        return  self::response($data ? true : false, $data ? '' : 'no '.$data.' found', $data);
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
        $support->complains;
        $data = array(
            'support' => $support,
        );
        return self::response($data ? true : false, $data ? 'successfully' : 'no support found', $data);
    }

}
