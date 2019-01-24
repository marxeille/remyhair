<?php

namespace App\Http\Controllers\Warehouse\Products;

use Illuminate\Http\Request;
use App\Http\Controllers\Warehouse\Products\CommonController;

class ProductExportController extends CommonController {

    /**
     *
     * @param Request $request
     * @return type
     */
    public function export(Request $request)
    {
        $user = $request->get('user');
        $this->json_ajax['success'] = $user->active;
        if ($user && $user->active) {
            $product = $request->get('product');
            if (count($product) && !$this->isOutofstockProduct($product)) {
                $quantity = $product['quantity'];
                $product['quantity'] = (int) $this->getProductQuantity($product['barcode']) - $quantity;
                $obj_product = $this->product->updateOrCreate(
                        ['barcode' => $product['barcode']], $product
                );
                $obj_product->stockMvt()->create([
                    'employee_id' => $user->id,
                    'quantity' => $quantity,
                    'sign' => -1
                ]);
            }
        }
        $this->json_ajax['message'] = $user->active ? 'export successfully' : 'Your account had been disable';
        $this->json_ajax['data']['user'] = $user;
        return response()->json($this->json_ajax);
    }

    /**
     *
     * @param array $product
     * @return boolean
     */
    private function isOutofstockProduct($product)
    {   
        $avaiable_quantity = (int) $this->getProductQuantity($product['barcode']);
        return $product['quantity'] > $avaiable_quantity;  
    }

}
