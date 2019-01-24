<?php

namespace App\models;

use Illuminate\Database\Eloquent\Model;
use DB;

class EmployeeFamily extends Model
{
    protected $table = 'employee_family';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    public $name;
    public $date_of_birth;
    public $relation;
    public $current_job;
    public $id_employee;

    protected $fillable = [
        'id', 'name', 'date_of_birth', 'relation', 'current_job', 'created_at', 'updated_at', 'id_employee'
    ];

    public function employee() {
        return $this->belongsTo('App\Models\Employee','id_employee');
    }


}
