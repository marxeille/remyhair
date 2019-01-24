<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Employee;
use Event;
use App\Events\HistoryEvent;
use App\Http\Requests\EmployeeRequest;
use App\Models\EmployeeFamily;

class EmployeeController extends ControllerCore
{
    public function __construct(Request $request = null)
    {
        return parent::__construct($request, new Employee());
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
            "group_name" => [
                "foreign_key"=>'id_group',
                "relation_table" => 'group',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "name" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "date_of_birth" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "join_date" => [
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
            "active" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "created_at" => [
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
            $queryInfo = $this->_model->buildQuery($this->query_fields);
            $total = $queryInfo['query']->count();
            $data['page_limit'] = ceil($total / $this->item_limit);
            $data['current_page'] = $this->page_number;
            $offset = ($this->page_number - 1)  * $this->item_limit;
            $items = $this->_model->getList($queryInfo['query'], $offset, $this->item_limit)->toArray();
            $data['items_per_page'] = $this->item_limit;
            $data['total_items'] = $total;
       
            $items = Employee::checkIdGroup($request->user, $items);
     
            $data['items'] = array_values($items);
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

        return parent::response($status, $message, $data);
    }

   
    /**
     * @param EmployeeRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function add(EmployeeRequest $request) {
        $status = false;
        $msg = '';
        $data = array();
        if (isset($request->validator) && $request->validator->fails()) {
            $errors = $request->validator->errors()->toArray();
            $data = Employee::convertMessageBag($errors);
        } else {
            $input = $request->all();
            try {
                $current_employee = $request->user;
                $new_employee = Employee::create($input);
                $status = $new_employee ? true : false ;
                $new_employee->password = bcrypt($request->password);
                $new_employee->save();
                $new_employee->group_name = $new_employee->group->name;
                if ($new_employee) {
                    Event::fire(new HistoryEvent($current_employee->id, $new_employee->id, $request->path(), serialize($request->all()), $current_employee->name));
                }
                $msg = $status ? 'Added successfully.' : 'Something went wrong.' ;
                $data = [
                    'employee' => [
                        'id' => $new_employee->id,
                        'name' => $new_employee->name,
                        'email' => $new_employee->email,
                        'phone' => $new_employee->phone,
                        'date_of_birth' => $new_employee->date_of_birth,
                        'join_date' => $new_employee->join_date,
                        'group_name' => $new_employee->group->name,
                        'id_group' => $new_employee->id_group,
                    ]
                ];
            } catch (\Exception $e) {
                $msg = 'Failed to create due to server error.';
            }

        }

        return self::response($status, $msg, $data);
    }

    /**
     * @param EmployeeRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit(Request $request) {
        $status = false;
        $msg = '';
        $data = array();
        $validator = \Validator::make($request->all(), [
            'email' => 'required|email|unique:employee,email,'.$request->id,
            'phone' => 'required|min:8||unique:employee,phone,'.$request->id,
            'name' => 'required',
            'id_group' => 'required',
            'join_date' => 'required',
            'address' => 'required'
        ]);
        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        } else {
            $input = $request->all();
            try {
                $employee = Employee::where('id', $request->id)->first();
                if($employee){
                    $employee->email = $input['email'];
                    $employee->phone = $input['phone'];
                    $employee->name = $input['name'];
                    $employee->id_group = $input['id_group'];
                    $employee->date_of_birth = $input['date_of_birth'];
                    $employee->join_date = $input['join_date'];
                    $employee->date_of_graduation = isset($input['date_of_graduation']) ? $input['date_of_graduation'] : $employee->date_of_graduation ;
                    $employee->date_of_contract = isset($input['date_of_contract']) ? $input['date_of_contract'] : $employee->date_of_contract;
                    $employee->facebook = isset($input['facebook']) ? $input['facebook'] : $employee->facebook ;
                    $employee->education = isset($input['education']) ? $input['education'] : $employee->education ;
                    $employee->school = isset($input['school']) ? $input['school'] : $employee->school ;
                    $employee->major = isset($input['major']) ? $input['major'] : $employee->major ;
                    $employee->address = $input['address'];
                    if($request->password){
                        $employee->password = bcrypt($request->password);
                    }
                    $employee->save();
                    $status = $employee ? true : false;
                    $employee->group_name = $employee->group->name;
                    $msg = $status ? 'Updated successfully' : 'Something went wrong.';
                    $data = [
                        'employee' => $employee,
                    ];
                }else{
                    $data = 'no employee found';
                    $status = false;
                }
            } catch (\Exception $e) {
                $msg = 'Failed to create due to server error.';
            }

        }

        return self::response($status, $msg, $data);
    }

     /**
     * @param id
     * @param type
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete(Request $request){
        $status = false;
        $msg = '';
        $employee = Employee::find(isset($request->id) ? $request->id : null);
        if($employee && $employee->id != 3){
            $employee->delete();
            $status = true;
            $msg = "Deleted successfully";
        }else{
            $msg = "something went wrong";
        }
        return self::response($status, $msg);
    }
    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function getLeader()
    {
        $data = [];
        try{
            $data = $this->_model->getLeaders();
            $status = true;
            $msg = 'successfully';
        }catch(\Exception $e){
            $status = false;
            $msg = $e->getMessage();
        }
        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Request $request)
    {
        $customer = $this->_model->where('id', isset($request->id) ? $request->id : null)->first()->toArray();
        return  $this->response($customer ? true : false, $customer ? '' : 'no employee found', $customer);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function detail(Request $request){
        $employee = Employee::where('id', isset($request->id) ? $request->id : null)->first();
        $employee['group'] = $employee->group;
        $employee->employeeFamilys;
        $data = array(
            'employee' => $employee,
        );
        return self::response($data ? true : false, $data ? 'successfully' : 'no employee found', $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function addFamily(Request $request){
        $status = true;
        $msg = 'successfully';
        $data = array();

        $validator = \Validator::make($request->all(), [
            'name' => 'required',
        ]);
        if($validator->fails()){
            $status = false;
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        }else{
            if($status){
                $employee_family = new EmployeeFamily([
                        'id_employee' => $request->id,
                        'name' => $request->name ? $request->name : null ,
                        'current_job' => $request->current_job ? $request->current_job : null ,
                        'relation' => $request->relation ? $request->relation : null ,
                        'date_of_birth' => "2018-12-12",
                    ]);
                    $employee_family->save();
            }else{
                $status = false;
                $msg = 'failed';
            }
        }
        return $this->response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function ChangeStatus(Request $request){
        $status = true;
        $msg = 'successfully';
        if($request->id){
            $employee = Employee::find($request->id);
            if($employee){
                $employee->active = $request->active;
                $employee->save();
            }else{
                $status = false;
                $msg = 'faield';
            }
        }else{
            $status = false;
            $msg = 'faield';
        }
        return $this->response($status, $msg);
    }   
}
