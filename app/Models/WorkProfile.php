<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
use App\Models\ModelCore;

class WorkProfile extends ModelCore
{
    protected $table = 'work_profile';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

   
    protected $fillable = [
        'id', 'id_employee','id_procedure', 'id_leader', 'id_work_category', 'title', 'result', 'case', 'experience', 'hard', 'need_change', 'leader_edited_at', 'id_status', 'created_at', 'updated_at'
    ];

    public function employee() {
        return $this->belongsTo('App\Models\Employee', 'id_employee');
    }

    public function workCategory() {
        return $this->belongsTo('App\Models\WorkCategory', 'id_work_category');
    }

    public function status() {
        return $this->hasOne('App\Models\Status', 'id_work_profile');
    }

    public function comment() {
        return $this->hasMany('App\Models\WorkProfileComment', 'id_work_profile');
    }

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
            if($field != 'from' && $field != 'to' && $field != 'hard' && $field != 'leader_suggesstion') {
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
       // $query =   $query->where('archive', 0);
        if($employee->id_group != 1){
            $query =   $query->where('id_employee', $employee->id);
            $query =   $query->orWhere('id_leader', $employee->id);
        }
        return ['relations' => $relations, 'query' => $query];
    }

}

