<?php

namespace App\Models;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Model;
use App\Models\ModelCore;
class WorkCategory extends ModelCore
{
    protected $table = 'work_category';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    use SoftDeletes;
    protected $dates = ['deleted_at'];
    protected $fillable = [
        'id', 'title', 'created_at', 'updated_at'
    ];

    public function workProfiles(){
        return $this->hasMany('App\Models\WorkProfile', 'id_work_category');
    }
}
