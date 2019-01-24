<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CartProduct extends Model
{
    protected $table = 'cart_product';

    protected $fillable = [
         'id', 'id_cart', 'id_hair_size', 'id_hair_type', 'id_hair_style', 'id_hair_color', 'id_hair_draw', 'kg', 'price', 'created_at', 'updated_at'
    ];

    public function cart() {
        return $this->belongsTo('App\Models\Cart','id_cart');
    }

    public function hairSize() {
        return $this->belongsTo('App\Models\HairSize','id_hair_size');
    }

    public function hairType() {
        return $this->belongsTo('App\Models\HairType','id_hair_type');
    }

    public function hairStyle() {
        return $this->belongsTo('App\Models\HairStyle','id_hair_style');
    }

    public function hairColor() {
        return $this->belongsTo('App\Models\HairColor','id_hair_color');
    }

    public function hairDraw() {
        return $this->belongsTo('App\Models\HairDraw','id_hair_draw');
    }

    public function productImages(){
        return $this->hasMany('App\Models\Product_image','id_cart_product');
    }

    /**
     * @param array $hairs
     * @return array
     */
    public static function checkHairDataExsit(array $hairs){
        $errors = [];
        if(!empty($hairs)){
            foreach ($hairs as $key => $value) {
                switch ($key){
                    case 'id_hair_size':{
                        if(!HairSize::find($value)) $errors['id_hair_size'] = ['Invalid value'];
                        break;
                    }
                    case 'id_hair_type':{
                        if(!HairType::find($value)) $errors['id_hair_type'] = ['Invalid value'];
                        break;
                    }
                    case 'id_hair_color':{
                        if(!HairColor::find($value)) $errors['id_hair_color'] = ['Invalid value'];
                        break;
                    }
                    case 'id_hair_draw':{
                        if(!HairDraw::find($value)) $errors['id_hair_draw'] = ['Invalid value'];
                        break;
                    }
                    case 'id_hair_style':{
                        if(!HairStyle::find($value)) $errors['id_hair_style'] = ['Invalid value'];
                        break;
                    }
                    case 'id_employee':{
                        if(!Employee::find($value)) $errors['id_employee'] = ['Invalid value'];
                        break;
                    }
                    case 'id_carrier':{
                        if(!Carrier::find($value)) $errors['id_carrier'] = ['Invalid value'];
                        break;
                    }
                    case 'id_customer':{
                        if(!Customer::find($value)) $errors['id_customer'] = ['Invalid value'];
                        break;
                    }
                    case 'id_address':{
                        if(!Address::find($value)) $errors['id_address'] = ['Invalid value'];
                        break;
                    }
                }
            }
        }
        return $errors;
    }

    public static function init($id_cart, array $attributes)
    {
        $model = self::where([
            ['id_cart', $id_cart],
            ['id_hair_size', $attributes['id_hair_size']],
            ['id_hair_type', $attributes['id_hair_type']],
            ['id_hair_style', $attributes['id_hair_style']],
            ['id_hair_draw', $attributes['id_hair_draw']],
            ['id_hair_color', $attributes['id_hair_color']],
        ])->first();
        if($model){
                return $model;
        } else
            return new CartProduct($attributes);
    }

}
