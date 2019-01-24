<?php

namespace App\Models;
use App\Models\ModelCore;
use Illuminate\Database\Eloquent\SoftDeletes;
use DB;

class Customer extends ModelCore
{
    protected $table = 'customer';
    use SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'id', 'full_name', 'phone', 'email', 'social_netwok', 'type', 'is_special_customer', 'status', 'education', 'school', 'major', 'date_of_graduation',
        ' id_employee', 'source', 'password', 'created_at', 'updated_at'
    ];


    public function address(){
        return $this->hasMany('App\Models\Address' ,'id_customer');
    }

    public function employee(){
        return $this->belongsTo('App\Models\Employee', 'id_employee', 'id');
    }

    public function supports(){
        return $this->hasMany('App\Models\Support', 'id_customer');
    }

    public function orders(){
        return $this->hasMany('App\Models\Order', 'id_customer');
    }

    public function carts(){
        return $this->hasMany('App\Models\Cart', 'id_customer');
    }

    public static function search($key_word){
        return Customer::where(function($q) use ($key_word) {
            $q->orWhere('email', 'like', '%'.$key_word.'%');
            $q->orWhere('full_name', 'like', '%'.$key_word.'%');
            $q->orWhere('id', $key_word);
            $q->orWhere('phone', 'like', $key_word.'%');
        })->with('address')->get()->toArray();
    }

    public static function setBalance($id, $balance)
    {
        $customer = Customer::find($id);
        if($customer && $balance){
            $customer->customer_balance = $customer->customer_balance + abs($balance);
            $customer->save();
        }
        return;
    }

    public static function setCustomerBalance($id, $balance)
    {
        $customer = Customer::find($id);
        if($customer){
            $customer->customer_balance = $balance;
            $customer->save();
        }
        return;
    }

    /**
     * @param array $fields
     * @return array
     */
    public function buildQueryForUnsupportList(array $fields = [], $employee = null)
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
        $query = $query->where('customer.status', '=', 'New');
        if(isset($fields['from']) && isset($fields['to'])){
            $query = $query->whereBetween($this->table.'.created_at', [$fields['from'], $fields['to']]);
        }
        if($employee->id_group != 1 ){
            $query = $query->where($this->table.'.id_employee', $employee->id);
        }

        return ['relations' => $relations, 'query' => $query];
    }

    public static function prepareData($customer_fields, $customer) {
        $data = '';
        $end_array = [];
        foreach ($customer_fields as $key => $field) {
            $data .= str_replace(' ', '_', strtolower($field)).':'.$customer[$key].',';
        }
        $convert_to_array = explode(',', $data);

        for($i=0; $i < count($convert_to_array ); $i++){
            $key_value = explode(':', $convert_to_array[$i]);
            if ($key_value[0]) {
                $end_array[$key_value[0]] = $key_value[1];
            }
        }
        return $end_array;

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
        if($employee->id_group != 1 ){
            $query = $query->where($this->table.'.id_employee', $employee->id);
        }
        return ['relations' => $relations, 'query' => $query];
    }

}
