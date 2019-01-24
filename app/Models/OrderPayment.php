<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderPayment extends Model
{
    protected $table = 'order_payment';

    public function payment() {
        return $this->belongsTo('App\Models\Payment', 'id_payment');
    }

    public function Orders(){
        return $this->belongsTo('App\Models\Order' ,'id_order');
    }

    public static function addOrderPayment(Order $order, Payment $payment)
    {
        $order_payment = new OrderPayment();
        $order_payment->id_order = $order->id;
        $order_payment->id_payment = $payment->id;
        $order_payment->name = $payment->name;
        $order_payment->save();

        return $order_payment;
    }
}
