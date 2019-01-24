<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductImage extends Model
{
    protected $table = 'product_image';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    public $id;
    public $id_cart_product;

    protected $fillable = [
        'id', 'id_cart_product', 'created_at', 'updated_at'
    ];

    public function cartProduct(){
        return $this->belongsTo('App\Models\CartProduct', 'id_cart_product');
    }
}
