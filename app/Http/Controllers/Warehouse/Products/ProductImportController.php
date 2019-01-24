<?php

namespace App\Http\Controllers\Warehouse\Products;

use Illuminate\Http\Request;
use App\Http\Controllers\Warehouse\Products\CommonController;

class ProductImportController extends CommonController {

    /**
     * 
     * @param Request $request
     * @return type
     */
    public function import(Request $request)
    {
        $user = $request->get('user');
        $this->json_ajax['success'] = $user->active;
        if ($user && $user->active) {
            $product = $request->get('product');
        
            $quantity = $product['quantity'];
            $product['quantity'] += $this->getProductQuantity($product['barcode']);
            $obj_product = $this->product->updateOrCreate(
                ['barcode' => $product['barcode']],
                $product
            );
    
            $obj_product->stockMvt()->create([
                'employee_id' => $user->id,
                'quantity' => $quantity,
                'sign' => 1
            ]);
        }
        $this->json_ajax['data']['user'] = $user;
        $this->json_ajax['message'] = $user->active ? 'add successfully' : 'Your account had been disable';
        return response()->json($this->json_ajax);
    }

}
