<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StockMvt extends Model
{
    protected $table = 'stock_mvt';

    protected $fillable = [
        'product_id',
        'employee_id',
        'quantity',
        'sign',
    ];

    /**
     *
     * @return type
     */
    public function product(){
        return $this->belongsTo(Product::class);
    }

    /**
     *
     * @return type
     */
    public function employee(){
        return $this->belongsTo(Employee::class);
    }


}
