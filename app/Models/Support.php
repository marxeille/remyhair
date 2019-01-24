<?php

namespace App\Models;
use DB;

class Support extends ModelCore
{
    protected $table = 'support';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'id_customer', 'id_employee', 'id_invoice_status', 'invoice_number', 'source', 'status'
    ];

    public function customer(){
        return $this->belongsTo('App\Models\Customer', 'id_customer');
    }

    public function employee() {
        return $this->belongsTo('App\Models\Employee','id_employee');
    }

    public function notes(){
        return $this->hasMany('App\Models\Note', 'id_support');
    }

    public function invoice_status(){
        return $this->belongsTo('App\Models\InvoiceStatus', 'id_invoice_status');
    }

    public function payment(){
        return $this->belongsTo('App\Models\Payment', 'id_payment');
    }

    public function complains(){
        return $this->hasMany('App\Models\Complain', 'id_support');
    }


    public function buildQuery(array $fields = [], $employee = null)
    {
        $query = $this;
        $relations = [];

        $main_fields = [];
        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to') {
                if ($data['relation_table'] && !isset($data['relation_data'])) {
                    array_push($main_fields, $this->table . '.' . $data['foreign_key']);
                    array_push($main_fields, $data['relation_table'] . '.' . $data['field'] . ' AS ' . $field);
                    array_push($relations, $this->table . '.' . $data['relation_table']);
                } else if($data['relation_table'] && isset($data['relation_data'])){
                    array_push($main_fields, $data['relation_table'] . '.' . $data['field'] . ' AS ' . $field);
                }  else if(isset($data['special_field']) || isset($data['group_concat'])) {
                }
                else {
                    array_push($main_fields, $this->table . '.' . $field);
                }

            }
        }
        $query = $query->select($main_fields);
        foreach($fields as $field => $data) {
            if (isset($data['special_field'])) {
                $query->addSelect(DB::raw('datediff(CURDATE(),' .$this->table. '.`updated_at`)'));
            }
            if (isset($data['group_concat'])) {
                $query->addSelect(DB::raw('GROUP_CONCAT(`note`.`content`) AS `note`'));
            }
        }
        foreach ($fields as $field => $data) {
            if (isset($data['ignore']) && $data['ignore'] == false) {
                if($field != 'from' && $field != 'to') {
                    if ($data['relation_table'] && !isset($data['relation_data']) && !isset($data['join'])) {
                        $query = $query->where($data['relation_table'] . '.' . $data['field'], 'like', $data['value'] . '%');
                        $query = $query->join($data['relation_table'], $this->table . '.' . $data['foreign_key'], '=', $data['relation_table'] . '.id');
                        if ($data['sort_by'] != 'none' && $data['sort_by']) {
                            $query = $query->orderBy($data['relation_table'] . '.' . $data['field'], $data['sort_by']);
                        }
                    } else if($data['relation_table'] && isset($data['relation_data'])){
                        $query = $query->where($data['relation_table'] . '.' . $data['field'], 'like', $data['value'] . '%');
                    } else if(isset($data['special_field']) && $data['value']) {
                        $query = $query->whereRaw('datediff(CURDATE(),' .$this->table. '.`updated_at`) = '. $data['value']);
                    } else if(isset($data['join'])) {
                        $query = $query->leftJoin($data['relation_table'], $this->table . '.' . $data['foreign_key'], '=', $data['relation_table'] . '.' .$data['owner_key']);
                    } else {
                        $query = $query->where($this->table . '.' . $field, 'like', $data['value'] . '%');
                        if ($data['sort_by'] != 'none' && $data['sort_by']) {
                            $query = $query->orderBy($this->table . '.' .$field, $data['sort_by']);
                        }
                    }
                }
            } else {
                continue;
            }
        }
        if(isset($fields['from']) && isset($fields['to'])){
            $query = $query->whereBetween($this->table.'.created_at', [$fields['from'], $fields['to']]);
        }
        if($employee->id_group != 1){
            $query =  $query->where($this->table.'.id_employee', $employee->id);
        }
        $query->groupBy($this->table.'.id');
        return ['relations' => $relations, 'query' => $query];
    }


}
