<?php

namespace App\models;

use Illuminate\Database\Eloquent\Model;

class OrderStatus extends Model
{
    protected $table = 'order_status';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */


    protected $fillable = [
        'id', 'status', 'created_at', 'updated_at'
    ];

    public function orders(){
        return $this->hasMany('App\Models\Order', 'current_status');
    }

    public function orderState()
    {
        return $this->hasMany('App\Models\OrderState');
    }
}
