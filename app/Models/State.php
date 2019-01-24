<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class State extends Model
{
    protected $table = 'state';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */


    protected $fillable = [
        'id', 'id_country', 'name', 'created_at', 'updated_at'
    ];

    public function addresss(){
        return $this->hasMany('App\Models\Address' , 'id_state');
    }

    public function country() {
        return $this->belongsTo('App\Models\Country' , 'id_country');
    }
}
