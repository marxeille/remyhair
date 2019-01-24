<?php

namespace App\Http\Controllers\Warehouse\Products;

use Illuminate\Http\Request;
use App\Http\Controllers\Warehouse\Products\CommonController;

class BarcodeScannerController extends CommonController {

    /**
     *
     * @param Request $request
     * @return type
     */
    public function scanBarcode(Request $request)
    {
        $user = $request->get('user');
        $this->json_ajax['success'] = $user->active;
        if ($user && $user->active) {
            $barcode = $request->get('barcode');
            $product = $this->product::select('*')->where('barcode', '=', $barcode)->get()->first();
            
            $this->json_ajax['data']['product'] = [
                'id' => $product ? $product->id : 0,
                'type' => $product ? $product->type : 0,
                'hair_size_id' => $product ? $product->hair_size_id : 0,
                'hair_style_id' => $product ? $product->hair_style_id : 0,
                'hair_color_id' => $product ? $product->hair_color_id : 0,
                'hair_type_id' => $product ? $product->hair_type_id : 0,
                'classtify' => $product ? $product->classtify : '',
                'standard' => $product ? $product->standard : '',
                'typeName' => $product ? $product->getTypeName() : '',
                'styleName' => $product ? (isset($product->hairStyle) ? $product->hairStyle->name : null) : '',
                'sizeName' => $product ? (isset($product->hairSize) ? $product->hairSize->name : null) : '',
                'colorName' => $product ? (isset($product->hairColor) ? $product->hairColor->name : null) : '',
                'barcode' => $product ? $product->barcode : '',
                'quantity' => $product ? $product->quantity : ''
            ];
            $this->json_ajax['message'] = $product ? 'product found' : 'product not found';
            $this->json_ajax['success'] = $product ?  true : false;
        }
        $this->json_ajax['data']['user'] = $user;
        return response()->json($this->json_ajax);
    }
}
