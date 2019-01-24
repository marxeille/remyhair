<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
use App\Models\ModelCore;

class WorkProfileComment extends ModelCore
{
    protected $table = 'work_profile_comment';

    public $fillable = ['id_work_profile', 'id_employee', 'comment'];

    public function workProfile() {
        return $this->belongsTo('App\Models\WorkProfile', 'id_work_profile');
    }

    public function employee() {
        return $this->belongsTo('App\Models\Employee', 'id_employee');
    }
}
