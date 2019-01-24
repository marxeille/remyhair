<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HairStyle extends ModelCore
{
    protected $table = 'hair_style';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'name', 'created_at', 'updated_at'
    ];

    public function cartProducts() {
        return $this->hasMany('App\Models\CartProduct','id_hair_style');
    }

    public function orderDetails() {
        return $this->hasMany('App\Models\OrderDetail','id_hair_style');
    }

    public function reportByType()
    {
        return $this->hasMany('App\Models\ReportHairStyleType', 'id_hair_style');
    }
}
