<?php

namespace App\Models;

use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use App\Models\ModelCore;
use Illuminate\Auth\Authenticatable as AuthenticableTrait;
use Illuminate\Database\Eloquent\SoftDeletes;
use DB;
use Illuminate\Notifications\Notifiable;

class Employee extends ModelCore implements Authenticatable
{
    use AuthenticableTrait;
    use Notifiable;
    use SoftDeletes;
    //use SoftDeletes;
    protected $table = 'employee';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
   // protected $dates = ['deleted_at'];
    protected $dates = ['deleted_at'];
    protected $fillable = [
        'id', 'name', 'id_group', 'date_of_birth', 'join_date', 'date_of_contract', 'address', 'phone', 'email', 'school' ,'password', 'facebook', 'education', 'major', 'date_of_graduation',
        'id_employee_group', 'active', 'created_at', 'updated_at'
    ];

    protected $hidden = [
        'password',
    ];

    public function employeeFamilys() {
        return $this->hasMany('App\Models\EmployeeFamily','id_employee');
    }

    public function addresses() {
        return $this->hasMany('App\Models\Address','id_address');
    }

    public function group() {
        return $this->belongsTo('App\Models\Group','id_group', 'id');
    }

    public function customers() {
        return $this->hasMany('App\Models\Customer','id_employee');
    }

    public function orders() {
        return $this->hasMany('App\Models\Order', 'id_employee');
    }

    public function workProfiles(){
        return $this->hasMany('App\Models\WorkProfile', 'id_employee');
    }

    public function supports() {
        return $this->hasMany('App\Models\Support' ,'id_employee');
    }

    public function carts(){
        return $this->hasMany('App\Models\Cart', 'id_employee');
    }

    public function orderHistorys() {
        return $this->hasMany('App\Models\OrderHistory' ,'id_employee');
    }

    public function getLeaders()
    {
        return $this->where('id_group', 1)->orWhere('id_group', 2)->select(['id', 'name'])->get();
    }

    public static function getSaleMen()
    {
        return self::select(['id', 'name'])->get();
    }

    public static function checkIdGroup($current, $user_list) {
        foreach($user_list as $key => $user) {
            if ($current->id_group > $user['id_group']) unset($user_list[$key]);
        }
        return $user_list;
    }

    /**
     * @param Order $order
     * @param $id_user
     */
    public static function assginSaleCommisison(Order $order, $id_user)
    {
        $sale_man = Employee::where('id', $id_user)->first();
        if($sale_man){
            $sale_commissions = config('sale_commission');
            $kg = $order->getTotalKg();

            $sale_commission = array_filter($sale_commissions['group'], function ($commission) use ($kg){
                if($commission['max_kg'] == 0 && $kg >= $commission['min_kg']) return true;
                if($commission['min_kg'] <= $kg && $kg <= $commission['max_kg']) return true;
                if($commission['min_kg'] == 0 && $kg < $commission['max_kg']) return true;
            });
            $sale_commission_employee = SaleCommissionEmployee::where([['id_order', $order->id], ['id_employee', $sale_man->id]])->first();
            $sale_commission = array_values($sale_commission);
            if(!$sale_commission_employee){
                $sale_commission_employee = new SaleCommissionEmployee();
            }
            $sale_commission_employee->id_employee = $sale_man->id;
            $sale_commission_employee->id_order = $order->id;
            $sale_commission_employee->sale_commission = $sale_commission[0]['commission'] + $kg * $sale_commissions['per_kg'];
            $sale_commission_employee->save();
        }
    }

}
