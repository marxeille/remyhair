<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\History;

class HistoryController extends ControllerCore
{
    public function __construct(Request $request = null)
    {
        return parent::__construct($request, new History());
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function renderList(Request $request)
    {

        $fields = $request->get('fields');
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
        $this->query_fields = [
              "id" => [
                  "relation_table" => null,
                  "value" => "",
                  "sort_by" => null
              ],
              "id_item" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
                ],
              "model" =>[
                  "relation_table" => null,
                  "value" => "",
                    "sort_by" => null
              ],
              "employee_name" =>[
                "relation_table" => null,
                "value" => "",
                  "sort_by" => null
              ],
              "action" => [
                  "relation_table" => null,
                  "value" => "",
                    "sort_by" => null
              ],
              "created_at" => [
                "relation_table" => null,
                "value" => "",
                  "sort_by" => null
              ]
        ];

        if(!empty($fields)){
            foreach ($fields as $field => $value) {
               $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                $this->query_fields[$field]['value'] = $value['value'];
                $this->query_fields[$field]['sort_by'] = $value['sort_by'];
            }
        }
        return parent::renderList($request);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function reportList(Request $request)
    {
        $fields = $request->get('fields');
        $this->query_fields = [
            "id" => [
                "relation_table" => null,
                "value" => "",
                "sort_by" => null
            ],
            "id_item" => [
              "relation_table" => null,
              "value" => "",
              "sort_by" => null
              ],
            "model" =>[
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
            "action" => [
                "relation_table" => null,
                "value" => "",
                  "sort_by" => null
            ],
            "created_at" => [
              "relation_table" => null,
              "value" => "",
                "sort_by" => null
            ]
        ];
        $this->page_number = ($request->get('page_number')) ? (int)$request->get('page_number') : $this->page_number;
        $this->query_fields['from'] = isset($fields['from']) ? $fields['from'] : date("Y-m-d H:i:s", strtotime("-1 months"));
        $this->query_fields['to'] =  isset($fields['to']) ? $fields['to'] : date("Y-m-d H:i:s");
        $from = new \DateTime($this->query_fields['from']);
        $to = new \DateTime($this->query_fields['to']);
        $this->query_fields['from'] = $from->setTime(07,0, 0)->format('Y-m-d H:i:s');
        $this->query_fields['to'] = $to->setTime(23,59, 59)->format('Y-m-d H:i:s');

        if(!empty($fields)){
            foreach ($fields as $field => $value) {
                if($field != 'from' && $field != 'to'){
                    $this->query_fields[$field] = array_merge( $value, $this->query_fields[$field]);
                    $this->query_fields[$field]['value'] = $value['value'];
                    $this->query_fields[$field]['sort_by'] = $value['sort_by'];
                }
            }
        }

        return parent::reportList($request);
    }
}
