<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\ModelCore;
class SaleCommissionEmployee extends ModelCore
{
    protected $table = 'sale_commission_employee';

    public function order()
    {
        return $this->belongsTo('App\Models\Order', 'id_order');
    }

    public function employee()
    {
        return $this->belongsTo('App\Models\Employee', 'id_employee');
    }


    /**
     * @param array $fields
     * @return array
     */
    public function buildQuery(array $fields = [], $employee = null)
    {
        $query = $this;
        $relations = [];

        $query = \DB::table('sale_commission_employee')
            ->join('employee', 'sale_commission_employee.id_employee', '=', 'employee.id')
            ->select('sale_commission_employee.id as id', 'sale_commission_employee.id_employee as id_employee', 'employee.name as employee_name', \DB::raw('sum(sale_commission_employee.sale_commission) as sale_commission'))
            ->where([
                ['sale_commission_employee.id', 'like',  $fields['id']['value'].'%'],
                ['employee.name', 'like',  $fields['employee_name']['value'].'%'],
            ]);

            if(  $fields['sale_commission']['value']){
                $query = $query->where(['sale_commission', '=',  $fields['sale_commission']['value']] );
            }

          $query = $query->groupBy('sale_commission_employee.id_employee');

        return $query;

    }

    /**
     * @param array $fields
     * @return array
     */
    public function buildQueryForDetail(array $fields = [], $id)
    {
        $query = $this;
        $relations = [];

        $query = \DB::table('sale_commission_employee')
            ->join('employee', 'sale_commission_employee.id_employee', '=', 'employee.id')
            ->select('sale_commission_employee.id as id','sale_commission_employee.id_order as id_order','sale_commission_employee.id_employee as id_employee', 'employee.name as employee_name', 'sale_commission_employee.sale_commission as sale_commission')
            ->where([
                ['sale_commission_employee.id_employee', '=',  $id],
                ['employee.name', 'like',  $fields['employee_name']['value'].'%'],
            ]);

            if(  $fields['sale_commission']['value']){
                $query = $query->where('sale_commission', '=',  $fields['sale_commission']['value']);
            }

            if( $fields['id_order']['value']){
                $query = $query->where('id_order', '=',  $fields['id_order']['value']);
            }


        return $query;
    }

    /**
     * @param $request
     * @param bool $date_ship
     * @return mixed
     */
    public static function reportList($request, $date_ship = false)
    {
        $sale_commission =
            self::with(['employee' => function ($employee) {
            $employee->select('id', 'name');
        }])
            ->with(['order'=> function($order){
                $order->select('id');
            }]);

        if(isset($request['from']) && isset($request['to'])){
            $order = $date_ship ?
                $sale_commission->whereHas('order', function($order) use ($request){
                    $order->whereBetween('date_ship', [$request['from'], $request['to']]);
                })
                :  $sale_commission->whereHas('order', function($order) use ($request){
                    $order->whereBetween('created_at', [$request['from'], $request['to']]);
                });
        }
        $data['items'] = $sale_commission->get();
        if(!empty($data['items'])){
            foreach ($data['items'] as $sale_commission) {
                $sale_commission['total_kg'] = $sale_commission->order->getTotalKg();
            }
        }

        return $data;
    }

}
