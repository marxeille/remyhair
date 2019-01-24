<?php
/**
 * Created by PhpStorm.
 * User: SYSTEM
 * Date: 7/30/2018
 * Time: 9:17 AM
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ModelCore extends Model
{

    public function getList($query, $start = null, $limit = null)
    {
       return ($start>=0 && $limit) ? $query->offset($start)->limit($limit)->get() : $query->get();
    }

    /**
     * @param array $fields
     * @return array
     */
    public function buildQuery(array $fields = [], $employee = null)
    {
        $query = $this;
        $relations = [];

        $main_fields = [];
        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to') {
                if ($data['relation_table']) {
                    array_push($main_fields, $this->table . '.' . $data['foreign_key']);
                    array_push($main_fields, $data['relation_table'] . '.' . $data['field'] . ' AS ' . $field);
                    array_push($relations, $this->table . '.' . $data['relation_table']);
                } else {
                    array_push($main_fields, $this->table . '.' . $field);
                }
            }
        }
        $query = $query->select($main_fields);

        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to'
                && $field != 'hard'
                && $field != 'leader_suggesstion'
                && $field != 'note'
                && $field != 'reason'
            ) {
                if ($data['relation_table']) {
                    $query = $query->where($data['relation_table'] . '.' . $data['field'], 'like', $data['value'] . '%');
                    $query = $query->join($data['relation_table'], $this->table . '.' . $data['foreign_key'], '=', $data['relation_table'] . '.id');
                    if ($data['sort_by'] != 'none' && $data['sort_by']) {
                        $query = $query->orderBy($data['relation_table'] . '.' . $data['field'], $data['sort_by']);
                    }
                } else {
                    $query = $query->where($this->table . '.' . $field, 'like', $data['value'] . '%');
                    if ($data['sort_by'] != 'none' && $data['sort_by']) {
                        $query = $query->orderBy($field, $data['sort_by']);
                    }
                }
            }
        }
        if(isset($fields['from']) && isset($fields['to'])){
            $query = $query->whereBetween($this->table.'.created_at', [$fields['from'], $fields['to']]);
        }

        return ['relations' => $relations, 'query' => $query];
    }

    /**
     * @param array $fields
     * @return array
     */
    public function buildQueryById(array $fields = [], $employee)
    {
        $query = $this;
        $relations = [];

        $main_fields = [];
        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to') {
                if ($data['relation_table']) {
                    array_push($main_fields, $this->table . '.' . $data['foreign_key']);
                    array_push($main_fields, $data['relation_table'] . '.' . $data['field'] . ' AS ' . $field);
                    array_push($relations, $this->table . '.' . $data['relation_table']);
                } else {
                    array_push($main_fields, $this->table . '.' . $field);
                }
            }
        }
        $query = $query->select($main_fields);
        if ($employee->group->name !== 'Admin') {
            $query = $query->where($this->table.'.id_employee', $employee->id);
        }
        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to') {
                if ($data['relation_table']) {
                    $query = $query->where($data['relation_table'] . '.' . $data['field'], 'like', $data['value'] . '%');
                    $query = $query->join($data['relation_table'], $this->table . '.' . $data['foreign_key'], '=', $data['relation_table'] . '.id');
                    if ($data['sort_by'] != 'none' && $data['sort_by']) {
                        $query = $query->orderBy($data['relation_table'] . '.' . $data['field'], $data['sort_by']);
                    }
                } else {
                    $query = $query->where($this->table . '.' . $field, 'like', $data['value'] . '%');
                    if ($data['sort_by'] != 'none' && $data['sort_by']) {
                        $query = $query->orderBy($field, $data['sort_by']);
                    }
                }
            }
        }
        if(isset($fields['from']) && isset($fields['to'])){
            $query = $query->whereBetween($this->table.'.created_at', [$fields['from'], $fields['to']]);
        }
        return ['relations' => $relations, 'query' => $query];
    }

    /**
     * @param array $fields
     * @return array
     */
    public function buildReportListQuery(array $fields = [])
    {
        $query = $this;
        $relations = [];

        $main_fields = [];
        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to'){
                if($data['relation_table']){
                    array_push($main_fields, $this->table.'.'.$data['foreign_key']);
                    array_push($main_fields, $data['relation_table'].'.'.$data['field'].' AS '.$field);
                    array_push($relations, $this->table.'.'.$data['relation_table']);
                }else{
                    array_push($main_fields,$this->table.'.'.$field);
                }
            }

        }
        $query = $query->select($main_fields);

        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to'){
                if($data['relation_table']){
                    $query = $query->where($data['relation_table'].'.'.$data['field'], 'like', $data['value'].'%');
                    $query = $query->join($data['relation_table'], $this->table.'.'.$data['foreign_key'], '=', $data['relation_table'].'.id');
                    if($data['sort_by'] !='none' && $data['sort_by']){
                        $query =$query->orderBy($data['relation_table'].'.'.$data['field'], $data['sort_by']);
                    }
                }else{
                    $query = $query->where($this->table.'.'.$field, 'like', $data['value'].'%');
                    if($data['sort_by'] != 'none' && $data['sort_by']){
                        $query = $query->orderBy($field, $data['sort_by']);
                    }
                }
            }
        }
        if(isset($fields['from']) && isset($fields['to'])){
            $query = $query->whereBetween($this->table.'.created_at', [$fields['from'], $fields['to']]);
        }
        return ['relations' => $relations, 'query' => $query];
    }

    /**
     * @param array $fields
     * @return array
     */
    public function buildOrderReportQuery(array $fields = [], $date_ship = false)
    {
        $query = $this;
        $relations = [];

        $main_fields = [];
        $concat = [];
        foreach ($fields as $field => $data) {
            if($field != 'from' && $field != 'to' && $field != 'fromDateShip' && $field != 'toDateShip'){
                if($data['relation_table']){
                    if (isset($data['multi_join']) && $data['multi_join']) {
                        foreach ($data["multi_join"] as $table => $foreign_key) {
                            array_push($main_fields, $table.'.'.'name AS '.$foreign_key);
                        }
                    }
                    if (isset($data['single_join']) && $data['single_join']) {
                        foreach ($data["single_join"] as $_field) {
                            array_push($main_fields, $data['relation_table'].'.'.$_field);
                        }
                    }
                    array_push($main_fields, $this->table.'.'.$data['foreign_key']);
                    array_push($main_fields, $data['relation_table'].'.'.$data['field'].' AS '.$field);
                    array_push($relations, $this->table.'.'.$data['relation_table']);
                }else{
                    array_push($main_fields,$this->table.'.'.$field);
                }
            }

        }
        $query = $query->select($main_fields);
        
        // foreach($concat as $g_concat) {
        //     $query = $query->addSelect(DB::raw('group_concat('.$g_concat.') AS '.str_replace('.','_',$g_concat)));
        // }
        foreach ($fields as $field => $data) {
            if(isset($data['filter']) && $data['filter']) {
                if($field != 'from' && $field != 'to' && $field != 'fromDateShip' && $field != 'toDateShip'){
                    if($data['relation_table']){
                        
                        $query = $query->where($data['relation_table'].'.'.$data['field'], 'like', $data['value'].'%');
                        $query = $query->leftJoin($data['relation_table'], $this->table.'.'.$data['foreign_key'], '=', $data['relation_table'].'.'.$data['owner_key']);
                        if (isset($data['multi_join']) && $data['multi_join']) {
                            foreach ($data["multi_join"] as $table => $foreign_key) {
                                $query = $query->leftJoin($table, $data['relation_table'].'.'.$foreign_key, '=', $table.'.id');
                            }
                        }
                        if($data['sort_by'] !='none' && $data['sort_by']){
                            $query =$query->orderBy($data['relation_table'].'.'.$data['field'], $data['sort_by']);
                        }
                    }else{
                        $query = $query->where($this->table.'.'.$field, 'like', $data['value'].'%');
                        if($data['sort_by'] != 'none' && $data['sort_by']){
                            $query = $query->orderBy($field, $data['sort_by']);
                        }
                    }
                }
            }
        }
        if($date_ship){
            $query = $query->whereBetween($this->table.'.date_ship', [$fields['from'], $fields['to']]);
        }else{
            $query = $query->whereBetween($this->table.'.created_at', [$fields['from'], $fields['to']]);
        }
        return ['relations' => $relations, 'query' => $query];
    }

    public function getOrderStats(array $fields = [], $groupByStatus = true) {
        return $results = DB::select( DB::raw('SELECT 
        '.($groupByStatus ?'hs.`id`,
            hs.`name`,': '').'
            os.`name`,
        sum(od.`kg`) as kg
        
        FROM
            hair_size hs
        left JOIN
        order_detail od on od.`id_hair_size` = hs.`id`
        left JOIN
        order_state os on od.`status` = os.`id`
        WHERE
        od.`created_at` BETWEEN "'.$fields['from'].'" AND "'.$fields['to'].'"
        GROUP BY
        od.`status`' .( $groupByStatus ? ', hs.`id`' : '') ));
    }

    public function getOrderTotalKg(array $fields = []) {
        return $results = DB::select( DB::raw('SELECT
        sum(od.`kg`) AS kg
        FROM
            order_detail od
        INNER JOIN hair_size hs ON hs.id = od.id_hair_size
        WHERE
            od.`created_at` BETWEEN "'.$fields['from'].'" AND "'.$fields['to'].'"'));
    }

    /**
     * @param array $message_bag
     * @return \Illuminate\Http\Response
     */
    public static function convertMessageBag(array $message_bag) {
        $msg_content = array();
        foreach($message_bag as $key => $messages) {
            foreach($messages as  $message) {
                $msg_content[$key] = $message;
            }
        }
        return $msg_content;
    }

    public static function getAll($fields = [])
    {
        $select = !empty($fields) ? $fields : ['id', 'name'];

        return self::select($select)->get();
    }

}
