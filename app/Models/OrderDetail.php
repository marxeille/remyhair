<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderDetail extends Model
{
    protected $table = 'order_detail';

    protected $fillable = ['status'];

    public function order() {
        return $this->belongsTo('App\Models\Order','id_order');
    }

    public function hair_size() {
        return $this->belongsTo('App\Models\HairSize','id_hair_size');
    }

    public function hair_type() {
        return $this->belongsTo('App\Models\HairType','id_hair_type');
    }

    public function hair_style() {
        return $this->belongsTo('App\Models\HairStyle','id_hair_style');
    }

    public function hair_color() {
        return $this->belongsTo('App\Models\HairColor','id_hair_color');
    }

    public function hair_draw() {
        return $this->belongsTo('App\Models\HairDraw','id_hair_draw');
    }

    public function cartProduct() {
        return $this->hasOne('App\Models\CartProduct' ,'id_cart_product');
    }

    public static function addOrderDetail(Order $order, Cart $cart, $id_status)
    {
        $products = $cart->getCartProducts();
        $order->orderDetail()->delete();
        foreach ($products as $product) {
            $order_detail = new OrderDetail();
            $order_detail->id_order = $order->id;
            $order_detail->status = $id_status;
            $order_detail->kg = $product['kg'];
            $order_detail->price = $product['price'];
            $order_detail->id_cart_product = $product['id'];
            $order_detail->id_hair_size = $product['id_hair_size'];
            $order_detail->id_hair_type = $product['id_hair_type'];
            $order_detail->id_hair_color = $product['id_hair_color'];
            $order_detail->id_hair_draw = $product['id_hair_draw'];
            $order_detail->id_hair_style = $product['id_hair_style'];
            $order_detail->total = $product['total_price'];
            $order_detail->save();
        }
    }


    public static function reportWeft($request, $date_ship)
    {
        $weft_types = HairType::select('id', 'name')
            ->where('export_type', 'WEFT')
            ->with(['reportByStyle' => function($report){}])->get();
        $hair_styles = HairStyle::select('id', 'id_color')->whereHas('reportByType')->get()->keyBy('id')->toArray();
        $order_details = self::select('id_hair_size', 'id_hair_style', 'id_hair_type', \DB::raw('ROUND(sum(kg), 2) as total_kg'));
        $id_hair_type = [];
        if(isset($request['from']) && isset($request['to'])){
            $order_details = $date_ship ?
                $order_details->whereHas('order', function ($order) use ($request) {
                    $order->whereBetween('date_ship', [$request['from'], $request['to']]);
                })
                : $order_details->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order_details = $order_details->whereHas('order', function($order){
            $order = $order->where('type', 0);
        });
            $order_details = $order_details->where(function($order) use ($weft_types, $hair_styles, &$id_hair_type){
                foreach ($weft_types as $weft_type) {
                    array_push($id_hair_type, $weft_type->id);
                    $order->orWhere(
                        [[function($query) use ($weft_type, $hair_styles){
                        $query->where('id_hair_type', $weft_type->id);
                    }], [function($query) use ($weft_type, $hair_styles){
                            foreach ($weft_type->reportByStyle as $report) {
                                    $query->orWhere([['id_hair_style', $report->id_hair_style],[
                                        function($query) use ($report, $hair_styles){
                                           $query->whereIn('id_hair_color', json_decode($hair_styles[$report->id_hair_style]['id_color'], true));
                                        }]]);
                                };
                        }]
                    ]);
                }
            });
        $order_details_by_weft = $order_details->groupBy('id_hair_size', 'id_hair_style');
        $bulk_type = HairType::where('export_type', 'BULK')->get()->keyBy('id');
        $order_details_bulk =  self::select('id_hair_size', \DB::raw('ROUND(sum(kg), 2) as total_bulk_kg'));
        $order_details_weft =  self::select('id_hair_size', \DB::raw('ROUND(sum(kg), 2) as total_weft_kg'));
        if(isset($request['from']) && isset($request['to'])){
                $order_details_bulk = $date_ship ?
                    $order_details_bulk->whereHas('order', function ($order) use ($request) {
                        $order->whereBetween('date_ship', [$request['from'], $request['to']]);
                    })
                    : $order_details_bulk->whereBetween('created_at', [$request['from'], $request['to']]);
            $order_details_weft = $date_ship ?
                $order_details_weft->whereHas('order', function ($order) use ($request) {
                    $order->whereBetween('date_ship', [$request['from'], $request['to']]);
                })
                : $order_details_weft->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order_details_bulk = $order_details_bulk->whereHas('order', function($order){
            $order = $order->where('type', 0);
        });
        $order_details_bulk = $order_details_bulk->whereIn('id_hair_type', $bulk_type)->groupBy('id_hair_size')->get()->toArray();
        $order_details_weft = $order_details_weft->whereIn('id_hair_type', $id_hair_type)->groupBy('id_hair_size')->get()->toArray();
        $order_details_by_weft = $order_details_by_weft->whereIn('id_hair_type', $id_hair_type)->get()->groupBy('id_hair_size')->toArray();
        foreach ($order_details_weft as &$weft) {
            $weft['report'] = isset($order_details_by_weft[$weft['id_hair_size']]) ?  $order_details_by_weft[$weft['id_hair_size']] : [];
        }
        $re_format_order_details_bulk = [];
        foreach ($order_details_bulk as $bulk) {
            $re_format_order_details_bulk['size_'.$bulk['id_hair_size']] = $bulk;
        }
        $re_format_order_details_weft = [];
        foreach ($order_details_weft as $item) {
            $re_format_order_details_weft['size_'.$item['id_hair_size']] = $item;
        }
        $data['items'] = array_values(array_merge_recursive($re_format_order_details_weft, $re_format_order_details_bulk));
        foreach ($data['items'] as &$item) {
            if(is_array($item['id_hair_size'])){
                $item['id_hair_size'] = $item['id_hair_size'][0];
            }
        }
        $data['weft_type'] = $hair_styles;
        return $data;
    }

    /**
     * */
    public static function reportType($request, $date_ship)
    {
        $order_details = self::select('id_hair_type',  \DB::raw('ROUND(sum(kg), 2) as total_kg'))
        ->with('hair_type');
        ;
        if(isset($request['from']) && isset($request['to'])){
            $order_details = $date_ship ?
                $order_details->whereHas('order', function ($order) use ($request) {
                    $order->whereBetween('date_ship', [$request['from'], $request['to']]);
                })
                : $order_details->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order_details = $order_details->whereHas('order', function($order){
            $order = $order->where('type', 0);
        });
        $order_details = $order_details->groupBy('id_hair_type');
        $data['items'] = $order_details->get();
        return $data;
    }

    public static function reportSize($request, $date_ship)
    {
        $order_details = self::select('id_hair_size',  \DB::raw('ROUND(sum(kg), 2) as total_kg'))
        ->with('hair_size');
        if(isset($request['from']) && isset($request['to'])){
            $order_details = $date_ship ?
                $order_details->whereHas('order', function ($order) use ($request) {
                    $order->whereBetween('date_ship', [$request['from'], $request['to']]);
                })
                : $order_details->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order_details = $order_details->whereHas('order', function($order){
            $order = $order->where('type', 0);
        });
        $order_details = $order_details->groupBy('id_hair_size');
        $data['items'] = $order_details->get();
        return $data;
    }

    /**
     * */
    public static function reportClosure($request, $date_ship)
    {
        $closure_type = HairType::select('id')->where('export_type', 'CLOSURE')->get()->toArray();
        $order_details = self::select('id_hair_size', 'id_hair_type',  \DB::raw('ROUND(sum(kg), 2) as total_kg'));
        $order_details = $order_details->whereIn('id_hair_type', $closure_type);
        $order_details = $order_details->groupBy('id_hair_size', 'id_hair_type');
        if(isset($request['from']) && isset($request['to'])){
            $order_details = $date_ship ?
                $order_details->whereHas('order', function ($order) use ($request) {
                    $order = $order->where('type', 0)->whereBetween('date_ship', [$request['from'], $request['to']]);
                })
                : $order_details->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order_details = $order_details->whereHas('order', function($order){
            $order = $order->where('type', 0);
        });
        $data['items'] = $order_details->get()->groupBy('id_hair_size')->toArray();
        $pagination['items_per_page'] = 1;
        $data['pagination'] = $pagination;
        $data['closure_type'] =   $closure_type;

        return $data;
    }

    /**
     * @param $request
     * @param bool $date_ship
     * @return mixed
     */
    public static function reportStats($request, $date_ship = false)
    {
        $order_details = self::select('id_hair_size', 'status',  \DB::raw('ROUND(sum(kg), 2) as total_kg'));
        $order_details = $order_details->groupBy('id_hair_size', 'status');
        if(isset($request['from']) && isset($request['to'])){
            $order_details = $date_ship ?
                $order_details->whereHas('order', function ($order) use ($request) {
                    $order->whereBetween('date_ship', [$request['from'], $request['to']]);
                })
                : $order_details->whereBetween('created_at', [$request['from'], $request['to']]);
        }
        $order_details = $order_details->whereHas('order', function($order){
            $order = $order->where('type', 0);
        });
        $data['items'] = $order_details->get()->groupBy('id_hair_size')->toArray();
        return $data;
    }

    public static function clearByIdEditingOrder($id_order)
    {
        return self::where('id_order', $id_order)->delete();
    }
}
