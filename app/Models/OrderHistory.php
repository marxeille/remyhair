<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderHistory extends Model
{
    protected $table = 'order_history';

    public function Order(){
        return $this->belongsTo('App\Models\Order', 'id_order');
    }

    public function Employee() {
        return $this->belongsTo('App\Models\Employee' ,'id_employee');
    }

    public function OrderState() {
        return $this->belongsTo('App\Models\OrderState' ,'id_order_state');
    }

    public static function addOrderHistory(Order $order, Employee $employee)
    {
        $order_history = new OrderHistory();
        $order_history->id_order = $order->id;
        $order_history->id_employee = $employee->id;
        $order_history->id_order_state = $order->current_status;

        $order_history->save();
    }
}
