<?php

namespace App\Http\Controllers;

use App\Models\Helper;
use App\Models\WorkProfile;
use App\Models\Employee;
use App\Models\WorkProfileComment;
use Illuminate\Http\Request;
use App\Models\WorkCategory;
use App\Models\Procedure;
use App\Models\ProcedureStep;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;
use phpDocumentor\Reflection\Types\Parent_;
use App\Events\InstallEvent;
use App\Events\EmailEvent;
use Event;
use App\Events\HistoryEvent;

class WorkProfileController extends ControllerCore
{
    public function __construct(Request $request = null)
    {
        return parent::__construct($request,new WorkProfile());
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
            'id_employee' => 'required|integer',
            'id_leader' => 'required|integer',
            'id_work_category' => 'required|integer',
            'id_procedure' => 'required|integer',
            'title' => 'required',
            'id_status' => 'required|integer',
        ]);

        if($validator->fails()){
            $status = false;
            $data = $validator->errors()->toArray();
            $msg = 'failed';
        }else{
            $employee = Employee::find($request->id_employee);
            $current_employee = $request->user;
            $work_category = WorkCategory::find($request->id_work_category);
            $procedure = Procedure::find($request->id_procedure);
            $procedure_step = ProcedureStep::find($request->id_status);
            $leader = Employee::find($request->id_leader);
            if ($employee && $status && $work_category && $procedure && $procedure_step && $leader) {
                $input = $request->all();
                $work_profile = new WorkProfile($input);
                $new_work_profile = $employee->workProfiles()->save($work_profile);
                if ($new_work_profile) {
                    Event::fire(new HistoryEvent($current_employee->id, $new_work_profile->id, $request->path(), serialize($request->all()), $current_employee->name));
                    try{
                        Helper::sendMail($leader->email, 'A new work profile has been assogned to you', View('work_profile.assign',
                            [
                                'name_employee' => $leader->name,
                                'id_work_profile' => $work_profile->id
                            ])->render());
                    }catch(\Exception $e){
                        \Log::alert($e->getMessage());
                    }

                }
                $data = [
                    'work_profile' => [
                        'id' => $work_profile->id,
                        'employee_name' => $employee->name,
                        'status' => $procedure_step->name,
                        'id_procedure' => $procedure->title,
                        'title' => $work_profile->title,
                        'work_category_name' => $work_category->title,
                    ]
                ];
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
    public function get(Request $request)
    {
        $work_profile = $this->_model->where('id', isset($request->id) ? $request->id : null)
            ->with(['comment' => function($c){
            return $c->with('employee');
        }])->with('employee')->first()->toArray();

        return  self::response($work_profile ? true : false, $work_profile ? '' : 'no work profile found', $work_profile);
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
            $work_profile = WorkProfile::where('id', $request->id)->first();
            if($work_profile && ($work_profile->id_employee == $request->user->id || $request->user->id == $work_profile->id_leader || $request->user->id_group == 1)){
                $work_profile->archive = 1;
                $work_profile->save();
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
            "employee_name" => [
                "foreign_key"=>'id_employee',
                "relation_table" => 'employee',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "status" => [
                "foreign_key"=>'id_status',
                "relation_table" => 'procedure_step',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "work_category_name" => [
                "foreign_key"=>'id_work_category',
                "relation_table" => 'work_category',
                "owner_key" => 'id',
                "field" => 'title',
                "value" => "",
                "sort_by" => null
            ],
            "id_procedure" => [
                "foreign_key"=>'id_procedure',
                "relation_table" => 'procedure',
                "owner_key" => 'id',
                "field" => 'title',
                "value" => "",
                "sort_by" => null
            ],
            "title" => [
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
        return parent::renderList($request);
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
            "employee_name" => [
                "foreign_key"=>'id_employee',
                "relation_table" => 'employee',
                "owner_key" => 'id',
                "field" => 'name',
                "value" => "",
                "sort_by" => null
            ],
            "id_leader" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "id_employee" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "status" => [
                "foreign_key"=>'id_status',
                "relation_table" => 'procedure_step',
                "owner_key" => 'id',
                "field" => 'id',
                "value" => "",
                "sort_by" => null
            ],
            "work_category_name" => [
                "foreign_key"=>'id_work_category',
                "relation_table" => 'work_category',
                "owner_key" => 'id',
                "field" => 'title',
                "value" => "",
                "sort_by" => null
            ],
            "id_procedure" => [
                "foreign_key"=>'id_procedure',
                "relation_table" => 'procedure',
                "owner_key" => 'id',
                "field" => 'title',
                "value" => "",
                "sort_by" => null
            ],
            "title" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "hard" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "leader_suggesstion" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "created_at" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "position" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
        ];

        if(!$this->query_fields['id_procedure']['value']){
            $this->query_fields['id_procedure']['value'] = Procedure::getFirst()->title;
        }

        $procerdures = Procedure::with('procedureSteps')->get();
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
        return parent::renderKanban($request, $procerdures);
    }

     /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function addCategory(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validate = Validator::make($request->all() ,[
            'title' => 'required|unique:work_category,title',
        ]);
        if($validate->fails()){
            $msg = $validate->errors()->toArray();
        }else{
            $category = new WorkCategory();
            $category->title = $request->title;
            $category->save();
            $status = true ;
            $msg = "Add successfully";
            $data = [
                'category' => $category
            ];
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateSuggesstion(Request $request)
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
            $work_profile = WorkProfile::where('id', $request->id)->first();
            if($work_profile && $work_profile->id_leader == $request->user->id){
                $work_profile->leader_suggesstion = $request->suggesstion;
                $work_profile->save();
                $status = true;
                $data = [
                    'id' => $request->id,
                    'suggesstion' => $request->suggesstion
                ];
            }else{
                $msg = 'Work profile not found';
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
            'title' => 'required',
            'id_employee' => 'required|integer',
            'id_leader' => 'required|integer',
            'id_work_category' => 'required|integer',
            'id_procedure' => 'required|integer',
            'id_status' => 'required|integer',
        ]);
        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
        } else {
            $employee = Employee::find($request->id_employee);
            $work_profile = WorkProfile::find($request->id);
            $work_category = WorkCategory::find($request->id_work_category);
            $procedure = Procedure::find($request->id_procedure);
            $procedure_step = ProcedureStep::find($request->id_status);
            if ($work_profile && $work_category && $procedure && $employee && $procedure_step) {
                $status = true;
                $work_profile->id_leader = $request->id_leader;
                $work_profile->id_work_category = $work_category->id;
                $work_profile->id_procedure = $procedure->id;
                $work_profile->title = $request->title;
                $work_profile->case = $request->case;
                $work_profile->result = $request->result;
                $work_profile->experience = $request->experience;
                $work_profile->hard = $request->hard;
                $work_profile->need_change = $request->need_change;
                $work_profile->id_status = $request->id_status;
                if ($request->id_leader == $employee->id) {
                    $work_profile->leader_suggesstion = $request->leader_suggesstion;
                    $work_profile->leader_edited_at = Carbon::now();
                }
                $work_profile->save();
                try{
                    $leader = Employee::where('id', $work_profile->id_leader)->first();
                    Helper::sendMail($leader->email, 'A work profile has been change', View('work_profile.assign',
                        [
                            'name_employee' => $leader->name,
                            'id_work_profile' => $work_profile->id
                        ])->render());
                }catch(\Exception $e){
                    \Log::alert($e->getMessage());
                }
                $msg = 'Updated successfully';
                $data = [
                    'work_profile' => [
                        'id' => $work_profile->id,
                        'employee_name' => $employee->name,
                        'status' => $procedure_step->name,
                        'id_procedure' => $procedure->title,
                        'title' => $work_profile->title,
                        'work_category_name' => $work_category->title,
                    ]
                ];
            } else {
                $msg = 'Work Profile could not be found.';
            }
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function addComment(Request $request) {
        $status = false;
        $msg = '';
        $data = array();
        $validator = Validator::make($request->all(), [
            'id_work_profile' => 'required',
            'id_employee' => 'required',
            'comment' => 'required',
        ]);
        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
        } else {
            $employee = Employee::find($request->id_employee);
            $work_profile = WorkProfile::find($request->id_work_profile);
            if ($work_profile && $employee) {
                $work_profile->comment()->create([
                   'id_employee'=> $employee->id,
                   'comment'=> $request->comment,
                ]);
                $status = true;
                $msg = 'Updated successfully';
                $data = [];
            } else {
                $msg = 'Work Profile could not be found.';
            }
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function removeComment(Request $request) {
        $status = false;
        $msg = '';
        $data = array();
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
        } else {
            $comment =  WorkProfileComment::find($request->id);
            if ($comment && $comment->id_employee == $request->user->id) {
                $comment->delete();
                $status = true;
                $msg = 'Delete successfully';
                $data = [];
            } else {
                $msg = 'Work Profile could not be found.';
            }
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateComment(Request $request) {
        $status = false;
        $msg = '';
        $data = array();
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'comment' => 'required',
        ]);
        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
        } else {
            $activity =  WorkProfileComment::find($request->id);
            if ($activity && $activity->id_employee == $request->user->id) {
                $activity->comment = $request->comment;
                $activity->save();
                $status = true;
                $msg = 'Delete successfully';
                $data = [];
            } else {
                $msg = 'Work Profile could not be found.';
            }
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete(Request $request) {
        $status = false;
        $msg = '';
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $data = $validator->errors()->toArray();
        } else {
            $work_profile = $this->_model->where('id', isset($request->id) ? $request->id : null)->delete();
        }
        return self::response($work_profile ? true : false, $work_profile ? '' : 'no work profile found', []);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function editCategory(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validate = Validator::make($request->all() ,[
            'id' => 'required',
            'title' => 'required|unique:work_category,title,'.$request->id_work_category,

        ]);
        if($validate->fails()){
            $msg = $validate->errors()->toArray();
        }else{
            $category = WorkCategory::find($request->id_work_category);
            if($category){
                $input = $request->all();
                $category = WorkCategory::find($request->id_work_category);
                $category->fill($input)->save();;
                $msg = "Update successfully";
                $data = [
                    'category' => $category
                ];
                $status = true;
            }else{
                $msg = "Category does not exist";
            }

        }
        return self::response($status, $msg, $data);
    }

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function getListProcedures( )
    {
        $data = Procedure::with('procedureSteps')->get();
        if(!empty($data)) $data = $data->toArray();

          return self::response(true, 'successfully', $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function addProcedure(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validate = Validator::make($request->procedure ,[
            'name' => 'required',
        ]);
        $error = false;
        foreach ($request->procedure['steps'] as $step) {
            if(!$step['name']) $error = true;
            break;
        }
        if($validate->fails() || $error){
            $msg = $validate->errors() ? $validate->errors() ->toArray() : 'Step name can not be empty!';
        }else{
            $procedure = new Procedure();
            $procedure->title = $request->procedure['name'];
            $procedure->number = count($request->procedure['steps']);
            $procedure->save();
            ProcedureStep::addSteps($procedure, $request->procedure['steps']);
            $data = Procedure::where('id', $procedure->id)->with('procedureSteps')->first()->toArray();
            $status = true;
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function editProcedure(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();
        $validate = Validator::make($request->procedure ,[
            'title' => 'required',
        ]);
        $error = false;
        foreach ($request->procedure['procedure_steps'] as $step) {
            if(!$step['name']) $error = true;
            break;
        }
        if($validate->fails() || $error){
            $msg = $validate->errors() ? $validate->errors() ->toArray() : 'Step name can not be empty!';
        }else{
            $procedure = Procedure::find($request->procedure['id']);
            if($procedure){
                $procedure->title = $request->procedure['title'];
                $procedure->number = count($request->procedure['procedure_steps']);
                $procedure->save();
                ProcedureStep::editSteps($procedure, $request->procedure['procedure_steps']);
                $data = Procedure::where('id', $procedure->id)->with('procedureSteps')->first()->toArray();
                $status = true;
            }else{
                $msg = 'Not found procedure';
            }
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getProcedure(Request $request)
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
            $data = Procedure::where('id', $request->id)->with('procedureSteps')->first()->toArray();
            $status = true;
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function removeProcedure(Request $request)
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
            $procedure  = Procedure::find($request->id);
            if($procedure){
                $procedure->delete();
                $status = true;
            } else{
                $msg = 'Not found procedure';
            }
        }
        return self::response($status, $msg, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function updateState(Request $request)
    {
        $status = false;
        $msg = '';
        $data = array();

        $validate = Validator::make($request->all() ,[
            'workProfiles' => 'required|array',
        ]);
        if($validate->fails() ){
            $msg =$validate->errors()->toArray();
        }else{
            foreach ($request->workProfiles as $work_profile) {
                $w_p = WorkProfile::where('id', $work_profile['id'])->first();
                if($w_p){
                    $w_p->id_status = $work_profile['id_status'];
                    $w_p->position = $work_profile['position'];
                    $w_p->save();
                    $leader = Employee::where('id', $w_p->id_leader)->first();
                    Helper::sendMail($leader->email, 'A work profile has been change status', View('work_profile.assign',
                        [
                            'name_employee' => $leader->name,
                            'id_work_profile' => $w_p->id
                        ])->render());
                }
                array_push($data, $work_profile);
            }
          
            $status = true;
            $msg = 'successfully';
        }
        return self::response($status, $msg, $data);
    }
    
    public function sendEmailChangeStatus(Request $request){
        // Event::fire(new InstallEvent($request->workProfiles, "Remyhair", 'email'));
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function deleteStep(Request $request)
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
               $step = ProcedureStep::find($request->id);
               if($step){
                      $work_profiles = WorkProfile::where('id_status', $request->id)->get();
                      $default_id_status = ProcedureStep::where('id', '!=', $request->id)->first();
                   foreach ($work_profiles as $item) {
                            $item->id_status = $default_id_status->id;
                            $item->save();
                      }
                      $step->delete();
                   $status = true;
               }
            }
        return self::response($status, $msg, $data);
    }
}
