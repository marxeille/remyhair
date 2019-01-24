<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class Payment extends ModelCore
{
    protected $table = 'payment';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'name', 'created_at', 'updated_at'
    ];

    public function orderPayments () {
        return $this->hasMany('App\Models\OrderPayment','id_payment');
    }

    public function supports() {
        return $this->hasMany('App\Models\Support' ,'id_payment');
    }
}   
