<?php

namespace App\Http\Controllers;

use App\Events\HistoryEvent;
use App\Models\Address;
use App\Models\Customer;
use App\Models\Country;
use App\Models\State;
use App\Models\Employee;
use Illuminate\Http\Request;
use Event;
use DB;
use Illuminate\Support\Facades\Validator;

    class CustomerController extends ControllerCore
    {
        public $query_fields = [
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
            "full_name" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "phone" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "email" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "customer_balance" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "is_special_customer" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "status" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "created_at" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "type" =>[
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ]
        ];

        public function __construct(Request $request = null)
        {
            return parent::__construct($request, new Customer());
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function renderList(Request $request)
        {
            $fields = $request->get('fields');
            $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;

            $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime(config('remyhair.default_filter_time_from')));
            $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
            $from = new \DateTime($this->query_fields['from']);
            $to = new \DateTime($this->query_fields['to']);
            $this->query_fields['from'] = $from->format('Y-m-d 00:00:01');
            $this->query_fields['to'] = $to->format('Y-m-d 23:59:59');

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
        public function renderListUnSupport(Request $request)
        {
            $fields = $request->get('fields');
            $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;

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

            $data = [];
            $status = true;
            $message = 'successfully';
            try{
                $queryInfo = $this->_model->buildQueryForUnsupportList($this->query_fields, $request->user);
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
            $fields = $request->get('fields');
            $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
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
        public function add(Request $request) {
            $status = true;
            $msg = '';
            $data = array();
            $validator = \Validator::make($request->all(), [
                'email' => 'required|email|unique:customer,email',
                'phone' => 'required|min:8||unique:customer,phone',
                'full_name' => 'required',
                'type' => 'required',
                'address' => 'required|array'
            ]);

            if($validator->fails()){
                $status = false;
                $data = $validator->errors()->toArray();
                $msg = 'failed';
            }else{
                $employee = Employee::find(isset($request->id_employee) ? $request->id_employee : null);
                if ($employee && $status) {
                    $input = $request->all();
                    $customer = new Customer($input);
                    $new_customer = $employee->customers()->save($customer);
                    $new_customer->customer_balance = 0;
                    $new_customer->employee_name = $employee->name;
                    $added_address = Address::saveAddresses($new_customer, $request->address);
                    if($new_customer) {
                        Event::fire(new HistoryEvent($employee->id, $new_customer->id, $request->path(), serialize($request->all()), $employee->name));
                    }
                    if($added_address){
                        $data = [
                            'customer' => $new_customer
                        ];
                    }else{
                        $status = false;
                        $data = $added_address;
                    }

                }else {
                    $msg = 'failed';
                    $status = false;
                    if(!$employee) $data['id_employee'] = 'Employee does not exist';
                }
            }

            return self::response($status, $msg, $data);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function edit(Request $request) {
            $status = false;
            $msg = '';
            $data = array();
            $validator = Validator::make($request->all(), [
                'id' => 'required',
                'email' => 'required|email|unique:customer,email,'.$request->id,
                'phone' => 'required|min:8||unique:customer,phone,'.$request->id,
                'full_name' => 'required',
                'type' => 'required',
            ]);
            if ($validator->fails()) {
                $data = $validator->errors()->toArray();
            } else {
                $input = $request->all();
                $customer = Customer::where('id', $request->id)->with('employee')->first();
                if($customer){
                    $msg = 'Updated successfully';
                    $customer->email = $input['email'];
                    $customer->phone = $input['phone'];
                    $customer->full_name = $input['full_name'];
                    $customer->type = $input['type'];
                    $customer->status = $input['status'];
                    $customer->is_special_customer = $input['is_special_customer'];
                    // Event::fire(new HistoryEvent(1, $customer->id, 'edit', 'customer'));
                    $customer->update();
                    $customer->employee_name = $customer->employee->name;

                    $data = [
                        'customer' => $customer,
                    ];
                    $status = true;
                }else{
                    $data = 'Customer not found';
                }

            }
            return self::response($status, $msg, $data);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function get(Request $request)
        {
            $customer = $this->_model->where('id', isset($request->id) ? $request->id : null)->with('address')->first()->toArray();
            return  self::response($customer ? true : false, $customer ? '' : 'no customer found', $customer);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function editAddress(Request $request)
        {
            $update_address = Address::updateAddresses($request->all());
            if($update_address){
                $customers = $this->renderList($request);
                $data = [
                    'customers' => $customers->getData(),
                ];
                $status = true;
            }else{
                $status = false;
                $data = $update_address;
            }
            return self::response($status, 'successfully', $data);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function reportList(Request $request)
        {
            $fields = $request->get('fields');
            $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
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


            return parent::reportList($request);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function exportList(Request $request)
        {
            $fields = $request->get('fields');
            $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
            $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime(config('remyhair.default_filter_time_from')));
            $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
            $this->query_fields['type'] = [
                    "relation_table" => null,
                    "value" => "",
                    "sort_by" => null
                ];
            if(!empty($fields)){
                foreach ($fields as $field => $value) {
                    if($field != 'from' && $field != 'to'){
                        $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                        $this->query_fields[$field]['value'] = $value['value'];
                        $this->query_fields[$field]['sort_by'] = $value['sort_by'];
                    }
                }
            }

            return parent::exportList($request);
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
            if(!empty($request->key_word)){
                $customer = Customer::search($request->key_word);
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
        public function getAddress(Request $request)
        {
            $address = Address::where('id', isset($request->id) ? $request->id : null)->first()->toArray();
            return  self::response($address ? true : false, $address ? '' : 'no address found', $address);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function detail(Request $request){
            $customer = Customer::where('id', isset($request->id) ? $request->id : null)->first();
            $customer['employee'] = $customer->employee;
            $data = array(
                'customer' => $customer,
            );
            return self::response($data ? true : false, $data ? 'successfully' : 'no customer found', $data);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function delete(Request $request){
            $customer = Customer::where('id', isset($request->id) ? $request->id : null)->first();
            if($customer){
                $customer->delete();
                $status = true;
            }
            return self::response($customer ? true : false, $customer ? 'successfully' : 'no customer found', []);
        }

        /**
         * @param Request $request
         * @return \Illuminate\Http\JsonResponse
         */
        public function importCustomers(Request $request) {
            $customers = $request->customers;            
            $customer_fields = array_shift($customers);
            $data = [];
          
            foreach($customers as $customer) {
                array_push($data, Customer::prepareData($customer_fields, $customer));                
            }

            foreach ($data as $f_customer) {
                $employee = Employee::find($f_customer['id_employee']);
                if (isset($employee)) {
                    $customer = new Customer();
                    $customer->id_employee = $employee->id;
                    $customer->full_name = $f_customer['full_name'];
                    $customer->phone = $f_customer['phone'];
                    $customer->email = $f_customer['email'];
                    $customer->is_special_customer = 0;
                    $customer->type = $f_customer['type'];
                    $customer->status = $f_customer['status'];
                    $customer->save();
                    $customer_address = new Address();
                    $customer_address->id_customer = $customer->id;
                    $customer_address->id_country = Country::where('name', 'like', '%'. $f_customer['country'] . '%')->first() ? Country::where('name', 'like', '%'. $f_customer['country'] . '%')->first()->id : 1;
                    $customer_address->id_state = State::where('name', 'like', '%'. $f_customer['state'] . '%')->first() ? State::where('name', 'like', '%'. $f_customer['state'] . '%')->first()->id : 0;
                    $customer_address->address = $f_customer['address'];
                    $customer_address->save();

                }

            }

            $msg = 'scucessfully';
            $status = true;

            return $this->response($status, $msg, $data);
        }
    }
