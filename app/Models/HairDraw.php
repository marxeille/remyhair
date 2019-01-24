<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HairDraw extends ModelCore
{
    protected $table = 'hair_draw';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'name', 'created_at', 'updated_at'
    ];

    public function cartProducts() {
        return $this->hasMany('App\Models\CartProduct','id_hair_draw');
    }

    public function orderDetails() {
        return $this->hasMany('App\Models\OrderDetail','id_hair_draw');
    }

}
