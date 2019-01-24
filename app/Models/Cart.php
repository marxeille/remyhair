<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Customer;

class Cart extends Model
{
    protected $table = 'cart';

    protected $fillable = [
        'id', 'id_carrier', 'id_customer', 'id_employee', 'id_address', 'shipping_cost', 'discount', 'created_at', 'updated_at'
    ];

    public function carrier() {
        return $this->belongsTo('App\Models\Carrier', 'id_carrier');
    }

    public function cartProducts() {
        return $this->hasMany('App\Models\CartProduct', 'id_cart');
    }

    public function customer() {
        return $this->belongsTo('App\Models\Customer', 'id_customer');
    }

    public function employee() {
        return $this->hasOne('App\Models\Employee', 'id_employee');
    }

    public function address() {
        return $this->belongsTo('App\Models\Address', 'id_address');
    }


    protected static function boot() {
        parent::boot();
        static::deleting(function($check) {
            $check->cartProducts()->delete();
        });
    }

    /**
     * @return array
     */
    public function getCartSummaryDetails()
    {
        return [
            'id_cart' => (int) $this->id,
            'id_customer' =>  $this->id_customer,
            'id_carrier' => (int) $this->id_carrier,
            'id_address' => (int) $this->id_address,
            'discounts' =>  $this->discount,
            'shipping_cost' => $this->shipping_cost,
            'total' => $this->getCartTotal(),
            'customer_balance' => $this->getCustomerBalance(),
        ];
    }

    /**
     * @return int
     */
    public function getCustomerBalance()
    {
        $customer_balance = 0;
        if ($this->id_customer) {
            $customer = Customer::find($this->id_customer);
            $customer_balance = $customer->customer_balance;
        } 

        return $customer_balance;
    }


    /**
     * @return array
     */
    public function getCartTotal()
    {
        $total_products = $this->getTotalProducts();
        $total_order = $this->getTotalOrder();
        $totals = array(
            'products' => $total_products,
            'discount' => $this->discount,
            'shipping_cost' => $this->shipping_cost,
            'total_payment_fee' => $this->getTotalPaymentFee(),
            'sale' => $total_order,
        );

        return $totals;
    }

    /**
     * @return mixed
     */
    public function getCartProducts()
    {
        return $this->cartProducts()->get();
    }

    /**
     * @param array $products
     * @return int
     */
    public function getTotalProducts()
    {
       $total_product = 0;
       $products = $this->getCartProducts();
       if(!empty($products)){
           foreach ($products as $product) {
               $total_product += $product->total_price;
           }
       }

       return round($total_product, 2);
    }

    /**
     * @return int|mixed
     */
    public function getTotalOrder()
    {
        $total_products = $this->getTotalProducts($this->getCartProducts());
        $total_payment_fee = ($total_products - $this->discount + $this->shipping_cost) * $this->payment_fee/100;
        return round((float)$total_products, 2) - round($this->discount, 2) + round($this->shipping_cost, 2)  + round($total_payment_fee, 2) ;
    }

    /**
     * @return int|mixed
     */
    public function getTotalPaymentFee()
    {
        $total_products = $this->getTotalProducts($this->getCartProducts());
        $total_payment_fee = ($total_products - $this->discount + $this->shipping_cost) * $this->payment_fee/100;
        return round($total_payment_fee, 2);
    }
}
