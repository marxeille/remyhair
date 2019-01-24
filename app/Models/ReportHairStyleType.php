<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReportHairStyleType extends ModelCore
{
    protected $table = 'report_hair_style_type';

    public function hairStyle() {
        return $this->belongsToMany('App\Models\HairStyle','report_hair_style_type', 'id_hair_style', 'id');
    }

    public function hairType() {
        return $this->hasMany('App\Models\HairType','id_hair_type');
    }
}
