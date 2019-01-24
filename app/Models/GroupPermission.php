<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use DB;

class GroupPermission extends Model
{
    protected $table = 'group_permission';

    public static $groups = [
            'Admin',
            'Leader',
            'Normal'
        ];

    private static $roles = [
        [
            'name' => 'add-customer',
            'action' => 'customer/add'
        ],
        [    'name' => 'edit-customer',
            'action' => 'customer/edit'
        ],
        [
            'name' => 'list-customer',
            'action' => 'customer/list'
        ],
        [
            'name' => 'detail-customer',
            'action' => 'customer/detail'
        ],
        [  'name' => 'list-group',
            'action' => 'group/list'
        ],
        [
            'name' => 'edit-group',
            'action' => 'group/edit'
        ],
        [
            'name' => 'get-group',
            'action' => 'group/get'
        ],
        [
            'name' => 'add-support',
            'action' => 'support/add'
        ],
        [
            'name' => 'edit-support',
            'action' => 'support/edit'
        ],
        [
            'name' => 'remove-support',
            'action' => 'support/remove'
        ],
        [
            'name' => 'get-support',
            'action' => 'support/get'
        ],
        [
            'name' => 'send-email-when-add',
            'action' => 'workprofile/sendemail'
        ],
        [
            'name' => 'send-email-when-change-status',
            'action' => 'workprofile/sendemailchangestatus'
        ],
        [
            'name' => 'list-support',
            'action' => 'support/list'
        ],
        [
            'name' => 'get-customer',
            'action' => 'customer/get'
        ],
        [
            'name' => 'edit-address',
            'action' => 'address/edit'
        ],
        [  'name' => 'list-employee',
            'action' => 'employee/list'
        ],
        [
            'name' => 'add-employee',
            'action' => 'employee/add'
        ],
        [
            'name' => 'edit-employee',
            'action' => 'employee/edit'
        ],
        [
            'name' => 'remove-employee',
            'action' => 'employee/remove'
        ],
        [
            'name' => 'get-employee',
            'action' => 'employee/get'
        ],
        [
            'name' => 'detail-employee',
            'action' => 'employee/detail'
        ],
        [
            'name' => 'customer-list-by-employee',
            'action' => 'employee/customers'
        ],
        [
            'name' => 'supports-list-by-employee',
            'action' => 'employee/supports'
        ],
        [
            'name' => 'change-status-employee',
            'action' => 'employee/status'
        ],
        [
            'name' => 'list-leader',
            'action' => 'employee/leader/get'
        ],
        [
            'name' => 'report',
            'action' => 'report'
        ],
        [
            'name' => 'list-workprofile',
            'action' => 'workprofile/list'
        ],
        [
            'name' => 'get-workprofile',
            'action' => 'workprofile/get'
        ],
        [
            'name' => 'add-workprofile',
            'action' => 'workprofile/add'
        ],
        
        [
            'name' => 'edit-workprofile',
            'action' => 'workprofile/edit'
        ],
        [
            'name' => 'add-support',
            'action' => 'support/add'
        ],
        [    'name' => 'edit-support',
            'action' => 'support/edit'
        ],
        [
            'name' => 'detail-support',
            'action' => 'support/detail'
        ],
        [
            'name' => 'list-support',
            'action' => 'support/list'
        ],
        [
            'name' => 'list-procedure',
            'action' => 'procedure/list'
        ],
        [
            'name' => 'add-procedure',
            'action' => 'procedure/add'
        ],
        [
            'name' => 'get-procedure',
            'action' => 'procedure/get'
        ],
        [
            'name' => 'edit-procedure',
            'action' => 'procedure/edit'
        ],
        [
            'name' => 'remove-procedure',
            'action' => 'procedure/remove'
        ],
        [
            'name' => 'kanban-workprofile',
            'action' => 'workprofile/kanban'
        ],
        [
            'name' => 'edit-state-workprofile',
            'action' => 'workprofile/update'
        ],
        [
            'name' => 'list-order',
            'action' => 'order/list'
        ],
        [
            'name' => 'edit-order',
            'action' => 'order/detail/edit'
        ],
        [
            'name' => 'get-order',
            'action' => 'order/get'
        ], [
            'name' => 'change-state-order',
            'action' => 'order/state/change'
        ],[
            'name' => 'add-payment-order',
            'action' => 'order/payment/add'
        ],
        [
            'name' => 'list-hair-color',
            'action' => 'hair/list/color'
        ],
        [
            'name' => 'list-hair-size',
            'action' => 'hair/list/size'
        ],
        [
            'name' => 'list-hair-style',
            'action' => 'hair/list/style'
        ],
        [
            'name' => 'list-hair-draw',
            'action' => 'hair/list/draw'
        ],
        [
            'name' => 'list-hair-type',
            'action' => 'hair/list/type'
        ],
        //
        [
            'name' => 'add-hair-color',
            'action' => 'add/hair/color'
        ],
        [
            'name' => 'add-hair-size',
            'action' => 'add/hair/size'
        ],
        [
            'name' => 'add-hair-style',
            'action' => 'add/hair/style'
        ],
        [
            'name' => 'add-hair-draw',
            'action' => 'add/hair/draw'
        ],
        [
            'name' => 'delete-employee',
            'action' => 'employee/delete'
        ],
        [
            'name' => 'add-hair-type',
            'action' => 'add/hair/type'
        ],
        //
        [
            'name' => 'edit-hair-color',
            'action' => 'hair/edit/color'
        ],
        [
            'name' => 'edit-hair-size',
            'action' => 'hair/edit/size'
        ],
        [
            'name' => 'edit-hair-style',
            'action' => 'hair/edit/style'
        ],
        [
            'name' => 'edit-hair-draw',
            'action' => 'hair/edit/draw'
        ],
        [
            'name' => 'edit-hair-type',
            'action' => 'hair/edit/type'
        ],
        //
        [
            'name' => 'delete-hair-color',
            'action' => 'hair/delete'
        ],
        [
            'name' => 'delete-hair-size',
            'action' => 'hair/delete'
        ],
        [
            'name' => 'delete-hair-style',
            'action' => 'hair/delete'
        ],
        [
            'name' => 'delete-hair-draw',
            'action' => 'hair/delete'
        ],
        [
            'name' => 'delete-hair-type',
            'action' => 'hair/delete'
        ],[
            'name' => 'order-kanban',
            'action' => 'order/kanban'
        ],[
            'name' => 'order-change-states',
            'action' => 'order/states/update'
        ],[
            'name' => 'remove-procedure-steo',
            'action' => 'workprofile/step/delete'
        ],[
            'name' => 'remove-order-state',
            'action' => 'order/state/delete'
        ],[
            'name' => 'update-order-state',
            'action' => 'order/state/update'
        ],
        //
        [
            'name' => 'report-order-list',
            'action' => 'order/report/list'
        ],
        [
            'name' => 'export-order-list',
            'action' => 'order/export/list'
        ],
        [
            'name' => 'dashboard',
            'action' => 'dashboard/get'
        ],
        //
        [
            'name' => 'sale-commission-list',
            'action' => 'sale-commission/list'
        ],
        [
            'name' => 'sale-commission-detail',
            'action' => 'sale-commission/get'
        ],
        //
        [
            'name' => 'report-order-list',
            'action' => 'order/report/list'
        ],
        [
            'name' => 'export-order-list',
            'action' => 'order/export/list'
        ],
        [
            'name' => 'payment-list',
            'action' => 'payment/list'
        ],
        [
            'name' => 'payment-get',
            'action' => 'payment/get'
        ],
        [
            'name' => 'payment-edit',
            'action' => 'payment/edit'
        ],
        [
            'name' => 'payment-delete',
            'action' => 'payment/delete'
        ],[
            'name' => 'job-title-list',
            'action' => 'job-title/list'
        ],
        [
            'name' => 'job-title-get',
            'action' => 'job-title/get'
        ],
        [
            'name' => 'job-title-edit',
            'action' => 'job-title/edit'
        ],
        [
            'name' => 'job-title-delete',
            'action' => 'job-title/delete'
        ],[
            'name' => 'invoice-list',
            'action' => 'invoice/list'
        ],
        [
            'name' => 'invoice-get',
            'action' => 'invoice/get'
        ],
        [
            'name' => 'history-list',
            'action' => 'history/list'
        ],
        [
            'name' => 'invoice-edit',
            'action' => 'invoice/edit'
        ],
        [
            'name' => 'invoice-delete',
            'action' => 'invoice/delete'
        ],
        [
            'name' => 'export-order-list',
            'action' => 'order/export/list'
        ],
        [
            'name' => 'un-support-list',
            'action' => 'customer/un-support/list'
        ],
        [
            'name' => 'payment-add',
            'action' => 'payment/add'
        ],[
            'name' => 'job-title-add',
            'action' => 'job-title/add'
        ],
        [
            'name' => 'invoice-add',
            'action' => 'invoice/add'
        ],
        [
            'name' => 'add-employee-family',
            'action' => 'employeeFamily/add'
        ],
        [
            'name' => 'delete-customer',
            'action' => 'customer/delete'
        ],[
            'name' => 'render-customer-report',
            'action' => 'customer/report/list'
        ],[
            'name' => 'render-customer-export',
            'action' => 'customer/report/export'
        ],
        [
            'name' => 'add-leader-suggesstion',
            'action' => 'workprofile/suggesstion/update'
        ],[
            'name' => 'update-order',
            'action' => 'order/update'
        ],
        [
            'name' => 'comment-workprofile',
            'action' => 'workprofile/comment/add'
        ],
        [
            'name' => 'remove-comment-workprofile',
            'action' => 'workprofile/comment/remove'
        ],
        [
            'name' => 'update-comment-workprofile',
            'action' => 'workprofile/comment/update'
        ],
        [
            'name' => 'archive-workprofile',
            'action' => 'workprofile/archive'
        ],
        [
            'name' => 'archive-order',
            'action' => 'order/archive'
        ],
        [
            'name' => 'edit-order/get-cart',
            'action' => 'order/cart/init'
        ],
        [
            'name' => 'order/update-paid-order',
            'action' => 'order/paid/update'
        ],
    ];
    /**
     * @var array
     */
    public $fillable = ['id_group', 'action'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function group()
    {
        return $this->belongsTo('App\Models\group');
    }

    /**
     * @param $action
     * @param $id_group
     * @return bool
     */
    public static function hasRole($action, $id_group)
    {
        $status = false;
        $action = str_replace('/api/', '', $action);
        $role = array_filter(self::$roles, function ($r) use($action){
           return $r['action'] == $action;
        });
        if(!empty($role)){
            $group_action  = self::select('id')->where([['id_group', '=', $id_group], ['action', '=', $role]])->get();
            $status = count($group_action);
        }
        return $status;
    }

    public static function getRoles()
    {
        return self::$roles;
    }

    /**
     * @param $id_group
     * @return mixed
     */
    public static function deleteByIdGroup($id_group)
    {
        return self::where('id_group', $id_group)->delete();
    }

    public static function getActionsByIdGroup($id_group)
    {
        return self::where('id_group', $id_group)->get();
    }
}
