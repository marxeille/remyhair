<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class LeaderRole extends Model
{
    protected $table = 'leader_role';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    public $id;
    public $id_leader;
    public $id_group;
    public $title;

    protected $fillable = [
        'id', 'id_leader', 'id_group', 'created_at', 'updated_at'
    ];
}
