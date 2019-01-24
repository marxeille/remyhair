<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class History extends ModelCore
{
    protected $table = 'history';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'id_item', 'id_employee', 'action', 'employee_name', 'model', 'created_at', 'updated_at'
    ];
}
