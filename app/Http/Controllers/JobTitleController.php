<?php

namespace App\Http\Controllers;

use App\Models\WorkCategory;
use Illuminate\Http\Request;
use DB;
use Event;
use App\Events\HistoryEvent;
use Illuminate\Support\Facades\Validator;

class JobTitleController extends ControllerCore
{
    public function __construct(Request $request = null)
    {
        return parent::__construct($request, new WorkCategory());
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
            "title" =>[
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
            'title' => 'required|unique:work_category',
        ]);
        if($validator->fails()){
            $status = false;
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        }else{
            $data = new WorkCategory();
            $data->title = $request->title;
            $data->save();
            if ($data) {
                Event::fire(new HistoryEvent($current_employee->id, $data->id, $request->path(), serialize($request->all()), $current_employee->name));
            }
        }
        return $this->response($status, $msg, ['jobTitle' => $data]);
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
        $job_title = WorkCategory::find(isset($request->id) ? $request->id : null);
        if($job_title){
            $validator = \Validator::make($request->all(), [
                'title' => 'required|unique:work_category,title,' . $job_title->title,
            ]);
            if($validator->fails() && $job_title->title != $request->title){
                $status = false;
                $data = $validator->errors()->toArray();
                $msg = 'failed';
            }else{
                $job_title->title = $request->title;
                $job_title->save();
            }
        }else{
            $status = false;
            $msg = 'failed';
            $data['id_job_title'] = 'Job title does not exist';
        }

        return $this->response($status, $msg, $job_title ? $job_title->toArray() : $data );
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
            $job_title = WorkCategory::find($request->id);
            if($job_title){
                $job_title->delete();
                $status = true;
            }
        }
        return self::response($status, $msg, $data);
    }
}
