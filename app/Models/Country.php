<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class Country extends Model
{
    protected $table = 'country';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'name', 'created_at', 'updated_at'
    ];

    public function addresses() {
        return $this->hasMany('App\Models\Address','id_country');
    }

    public function states() {
        return  $this->hasMany('App\Models\State', 'id_country');
    }
}
