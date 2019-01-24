<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaidOrder extends Model
{
    protected $table = 'paid_order';

    public function order()
    {
        return $this->hasOne('App\Models\order', 'id_order');
    }

    public function payment()
    {
        return $this->belongsTo('App\Models\Payment', 'id_payment');
    }

    /**
     * @param Order $order
     * @param $paid
     * @param Payment $payment
     */
    public static function addPaid(Order $order, $paid, Payment $payment)
    {
        $paid_order = new PaidOrder();
        $paid_order->id_order = $order->id;
        $paid_order->paid = $paid;
        $paid_order->id_payment = $payment->id;

        $paid_order->save();
    }
}
