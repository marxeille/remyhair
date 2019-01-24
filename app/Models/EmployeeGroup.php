<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;
class EmployeeGroup extends Model
{
    protected $table = 'employee_group';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    public $id;
    public $title;

    protected $fillable = [
        'id', 'title', 'created_at', 'updated_at'
    ];

    public function employees() {
        return $this->hasMany('App\Models\Employee','id_employee_group');
    }
}
