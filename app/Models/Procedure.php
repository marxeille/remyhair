<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Procedure extends Model
{
    protected $table = 'procedure';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    
    protected $fillable = [
        'id', 'title', 'number', 'created_at', 'updated_at'
    ];

    public function procedureSteps(){
        return $this->hasMany('App\Models\ProcedureStep', 'id_procedure');
    }

    protected static function boot() {
        parent::boot();
        static::deleting(function($check) {
            $check->procedureSteps()->delete();
        });
    }

    public static function getFirst()
    {
        return Procedure::select('title')->first();
    }

}
