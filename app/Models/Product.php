<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\StockMvt;

class Product extends Model
{
    const TYPE = ['Vergin', 'Remy', 'Closure'];
    const CLASSTIFY = ['Chưa chạy', 'Đã chạy'];
    const STANDARD = ['Chặt khúc', 'Chưa chặt khúc', 'Chạy lại lần 1', 'Chạy lại lần 2'];

    protected $table = 'product';

    protected $fillable = [
        'type',
        'hair_size_id',
        'hair_style_id',
        'hair_type_id',
        'hair_color_id',
        'quantity',
        'classtify',
        'standard',
        'barcode',
    ];

    /**
     *
     * @return type
     */
    public function hairSize(){
        return $this->belongsTo(HairSize::class);
    }

    /**
     *
     * @return type
     */
    public function hairStyle(){
        return $this->belongsTo(HairStyle::class);
    }

    /**
     *
     * @return type
     */
    public function hairColor() {
        return $this->belongsTo(HairColor::class);
    }

    public function stockMvt(){
        return $this->hasMany(StockMvt::class, 'product_id');
    }

    public function getTypeName(){
        return self::TYPE[(int)$this->type];
    }

}
