<?php

namespace App\Http\Controllers\Warehouse\Products;

use App\Http\Controllers\Controller;
use App\Models\Product;

class CommonController extends Controller
{
    public $json_ajax = [
        'success' => true,
        'data' => [],
        'message' => ''
    ];
    
    public $product;

    /**
     *
     * @param Product $product
     */
    public function __construct(Product $product)
    {
        $this->product = $product;
    }
    public function getProductQuantity($barcode)
    {
        return (int)$this->product::select('quantity')->where('barcode', '=', $barcode)->value('quantity');
    }
}
