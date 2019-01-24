<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Complain extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $table = 'complain';
    protected $fillable = [
        'id', 'content', 'id_support', 'created_at', 'updated_at'
    ];

    public function support() {
        return $this->belongsTo('App\Models\Support', 'id_support');
    }
}
