<?php

namespace App\Http\Controllers;

use App\Models\SaleCommissionEmployee;
use Illuminate\Http\Request;
use Event;

class SaleCommissionController extends ControllerCore
{
    public $query_fields = [
        "id" => [
            "relation_table" => null,
            "value" => "",
            "sort_by" => null
        ],
        "employee_name" => [
            "foreign_key"=>'id_employee',
            "relation_table" => 'employee',
            "owner_key" => 'id',
            "field" => 'name',
            "value" => "",
            "sort_by" => null
        ],
        "sale_commission" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null
        ],
        "id_order" =>[
            "relation_table" => null,
            "value" => "",
            "sort_by" => null
        ],

    ];

    public function __construct(Request $request = null)
    {
        return parent::__construct($request, new SaleCommissionEmployee());
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderList(Request $request)
    {
        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
        $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime("-1 months"));
        $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
        $from = new \DateTime($this->query_fields['from']);
        $to = new \DateTime($this->query_fields['to']);
        $this->query_fields['from'] = $from->setTime(07,0, 0)->format('Y-m-d H:i:s');
        $this->query_fields['to'] = $to->setTime(23,30, 59)->format('Y-m-d H:i:s');
        $data = SaleCommissionEmployee::reportList($this->query_fields, $request->date_ship);
        $data['filters'] = $this->query_fields;

        return Parent::response(true, 'successully', $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderDetailList(Request $request)
    {
        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;

        if(!empty($fields)){
            foreach ($fields as $field => $value) {
                $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                $this->query_fields[$field]['value'] = $value['value'];
                $this->query_fields[$field]['sort_by'] = $value['sort_by'];
            }
        }
        $data = [];
        $status = true;
        $message = 'successfully';
        try{
            $queryInfo = $this->_model->buildQueryForDetail($this->query_fields, $request->id);
            $total = $queryInfo->count();
            $data['page_limit'] = ceil($total / $this->item_limit);
            $data['current_page'] = $this->page_number;
            $offset = ($this->page_number - 1)  * $this->item_limit;
            $data['items'] = $this->_model->getList($queryInfo, $offset, $this->item_limit);
            $data['items_per_page'] = $this->item_limit;
            $data['total_items'] = $total;
            foreach ($this->query_fields as &$query_field) {
                if(isset($query_field['relation_table'])) unset($query_field['relation_table']);
                if(isset($query_field['foreign_key'])) unset($query_field['foreign_key']);
                if(isset($query_field['owner_key'])) unset($query_field['owner_key']);
                if(isset($query_field['field'])) unset($query_field['field']);
            }
            $data['filters'] = $this->query_fields;
        }catch(\Exception $e){
            $status = false;
            $message = $e->getMessage();
        }

        return parent::response($status, $message, $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Request $request)
    {
        $customer = $this->_model->where('id', isset($request->id) ? $request->id : null)->with('address')->first()->toArray();
        return  self::response($customer ? true : false, $customer ? '' : 'no customer found', $customer);
    }
}
