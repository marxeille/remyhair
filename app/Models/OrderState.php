<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderState extends Model
{
    protected $table = 'order_state';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'created_at', 'updated_at'
    ];

    public function orderHistory() {
        return $this->hasMany('App\Models\OrderHistory', 'id_order_state');
    }

    public function orderStatus()
    {
        return $this->belongsTo('App\Models\OrderStatus', 'id_status');
    }


}
