<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProcedureStep extends Model
{
    protected $table = 'procedure_step';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */


    protected $fillable = [
        'id', 'id_procedure', 'name', 'number', 'created_at', 'updated_at'
    ];

    public function procedure() {
        return $this->belongsTo('App\Models\ProcedureStep', 'id_procedure');
    }

    public static function addSteps(Procedure $procedure, array $steps)
    {
        foreach ($steps as $step) {
            $s = new ProcedureStep();
            $s->id_procedure = $procedure->id;
            $s->name = $step['name'];
            $s->number = $step['number'];
            $s->save();
        }
    }

    public static function editSteps(Procedure $procedure, array $steps)
    {
        foreach ($steps as $step) {
            if(isset($step['add']) && $step['add']){
                $s = new ProcedureStep();
                $s->id_procedure = $procedure->id;
                $s->name = $step['name'];
                $s->number = $step['number'];
                $s->save();
            }else{
                $s = ProcedureStep::find($step['id']);
                if($s){
                    $s->name = $step['name'];
                    $s->number = $step['number'];
                    $s->save();
                }
            }
        }
    }
}
