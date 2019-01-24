<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;
class InvoiceStatus extends ModelCore
{
    protected $table = 'invoice_status';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $fillable = [
        'id', 'name', 'created_at', 'updated_at'
    ];

    public function supportDetail() {
        return $this->belongsTo('App\Models\supportDetail' ,'id_invoice_status');
    }
    
   
}
