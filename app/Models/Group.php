<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;

class Group extends Model
{
    protected $table = 'group';
    public $fillable = ['name'];

    public static function isHasRole($action)
    {

    }

    public function permission()
    {
        return $this->hasMany('App\Models\GroupPermission', 'id_group');
    }

    public function employee(){
        return $this->hasMany('App\Models\Employee', 'id_group');
    }
}
