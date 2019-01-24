<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;

class HairType extends ModelCore
{
    protected $table = 'hair_type';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'name', 'created_at', 'updated_at'
    ];

    public function cartProducts() {
        return $this->hasMany('App\Models\CartProduct','id_hair_tyle');
    }

    public function orderDetails() {
        return $this->hasMany('App\Models\OrderDetail','id_hair_tyle');
    }

    public function reportByStyle()
    {
        return $this->hasMany('App\Models\ReportHairStyleType','id_hair_type');
    }
    public function getHairStyleRelation() {
        $query = DB::table('report_hair_style_type');
        $query->select('id_hair_style');
        $query->where('id_hair_type', $this->id);
        return $query->get();
    }

    public function updateHairStyleRelation($styles) {
        $id_styles = [];
        foreach ($styles as $style) {
            array_push($id_styles, ['id_hair_style' => $style, 'id_hair_type' => $this->id]);
        }
        
        DB::table('report_hair_style_type')->where('id_hair_type', $this->id)->delete();
        $query = DB::table('report_hair_style_type');
        return $query->insert($id_styles);
    }
}
