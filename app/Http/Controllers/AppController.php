<?php

namespace App\Http\Controllers;

use App\Models\Carrier;
use App\Models\Country;
use App\Models\Employee;
use App\Models\Group;
use App\Models\GroupPermission;
use App\Models\HairColor;
use App\Models\HairDraw;
use App\Models\HairSize;
use App\Models\HairStyle;
use App\Models\HairType;
use App\Models\InvoiceStatus;
use App\Models\OrderState;
use App\Models\OrderStatus;
use App\Models\Payment;
use App\Models\State;
use App\Models\WorkCategory;
use App\Models\Procedure;
use App\Models\ProcedureStep;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;

class AppController extends ControllerCore
{
    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function init(Request $request)
    {
        $data = [];
        $data['payments'] = Payment::select('name', 'id')->get();
        $data['invoices_status'] = InvoiceStatus::select('name', 'id')->get();
        $data['countries'] = Country::select('name', 'id')->get();
        $data['states'] = State::select('name', 'id', 'id_country')->get();
        $data['hair_colors'] = HairColor::select('name', 'id')->get();
        $data['hair_styles'] = HairStyle::select('name', 'id')->get();
        $data['hair_sizes'] = HairSize::select('name', 'id')->get();
        $data['hair_draw'] = HairDraw::select('name', 'id')->get();
        $data['hair_types'] = HairType::select('name', 'id')->get();
        $data['actions'] = GroupPermission::getActionsByIdGroup($request->user->id_group);
        $data['groups'] = Group::all();
        $data['permissions'] = GroupPermission::getRoles();
        $data['employees'] = Employee::select('name', 'id', 'id_group')->get();
        $data['carriers'] = Carrier::select('id','name')->get();
        $data['work_category'] = WorkCategory::select('title', 'id')->get();
        $data['procedure'] = Procedure::select('title', 'id', 'number')->get();
        $data['order_status'] = array_map('current', OrderState::select('name')->get()->toArray());
        $data['order_states'] = OrderState::select('name', 'id')->get();
        $data['procedure_step'] = ProcedureStep::select('name', 'id', 'id_procedure', 'number')->get();
        $data['customer_type'] = [
            'normal', 'good', 'best'
        ];
        $data['source'] = [
            'Forwarded', 
            'Search',
            'Direct',
            'Referecence'
        ];
        $data['support_status'] = [
            'Open',
            'Closed'
        ];
        $data['cart'] = $this->cart;

        return $this->response(true, 'successfully', $data);
    }
}
