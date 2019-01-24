<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Carrier extends ModelCore
{
    protected $table = 'carrier';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'name', 'created_at', 'updated_at'
    ];

    public function cart()
    {
        return $this->hasMany('App\Models\Cart', 'id_cart');

    }

}
