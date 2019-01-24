<?php

namespace App\Http\Controllers\Warehouse\Products;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Warehouse\Products\CommonController;
use App\Models\HairColor;
use App\Models\HairSize;
use App\Models\HairStyle;
use App\Models\HairType;

use JWTAuth;

class ProductController extends CommonController {

     /**
     * 
     * @param Request $request
     * @return json
     */
    public function setting(Request $request) {
        $setting = [
            'size' => HairSize::getAll(),
            'style' => HairStyle::getAll(),
            'type' => HairType::getAll(),
            'color' => HairColor::getAll(),
            'remy_classtify' => ['Chưa chạy', 'Đã chạy'],
            'closure_classtify' => ['Free part', 'Three part', 'Middle part', '4 part'],
            'standard' => ['Chặt khúc', 'Chưa chặt khúc', 'Chạy lại lần 1', 'Chạy lại lần 2'],
        ];
        $this->json_ajax['data']['setting'] = $setting;
        $this->json_ajax['message'] = 'get success';
        return response()->json($this->json_ajax);
    }
    /**
     * 
     * @param Request $request
     * @return json
     */
    public function getList(Request $request)
    {
        $user = $request->get('user');
        $this->json_ajax['success'] = $user->active;
        if($user && $user->active) {
            $products = DB::table('product')->select(
                'product.id',
                'product.quantity',
                'hair_size.name as sizeName',
                'hair_style.name as styleName',
                'hair_type.name as typeName',
                'hair_color.name as colorName'
            )
            ->join('hair_size', 'hair_size.id', '=',  'product.hair_size_id')
            ->join('hair_style', 'hair_style.id',  '=', 'product.hair_style_id')
            ->join('hair_type', 'hair_type.id', '=', 'product.hair_type_id')
            ->join('hair_color', 'hair_color.id', '=', 'product.hair_color_id')
            ->orderBy('product.created_at','DESC')
            ->paginate(15);
            $this->json_ajax['data']['products'] = $products;
            $this->json_ajax['message'] = 'successful';
        }
        $this->json_ajax['data']['user'] = $user;
        return response()->json($this->json_ajax);
    }

    /**
     * 
     * @param Request $request
     * @return json
     */
    public function getHistory(Request $request) 
    {
        $user = $request->get('user');
        $this->json_ajax['success'] = $user->active;
        if($user && $user->active) {
            $product_id = $request->get('product_id');
            $histories = DB::table('stock_mvt')->select(
                'stock_mvt.sign',
                'stock_mvt.quantity',
                'stock_mvt.created_at as createAt',
                'employee.name as employeeName' 
            )
            ->join('employee', 'employee.id', '=',  'stock_mvt.employee_id')
            ->where('stock_mvt.product_id', '=', (int)$product_id)
            ->orderBy('stock_mvt.created_at','DESC')
            ->paginate(15);
            $this->json_ajax['data']['histories'] = $histories;
            $this->json_ajax['message'] = 'successful';
        }
        $this->json_ajax['data']['user'] = $user;
        return response()->json($this->json_ajax);
    }
}
