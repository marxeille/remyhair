<?php

namespace App\Http\Controllers;

use App\Models\Group;
use App\Models\GroupPermission;
use Illuminate\Http\Request;

class GroupController extends ControllerCore
{
    private $roles;

    public function __construct(Request $request = null)
    {
        $this->roles = GroupPermission::getRoles();
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit(Request $request)
    {
        $status = true;
        $msg = 'successfully';
        $data = [];

        $validator = \Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if($validator->fails()){
            $status = false;
            $data = $validator->errors();
            $msg = 'failed';
        }else{
            $group = Group::find($request->id);
            if($group){
                $permissions = $request->get('permissions');
                foreach ($permissions as $permission) {
                    $rs = array_filter($this->roles, function($r) use($permission){
                        return $r['action'] == $permission['action'];
                    });
                    if(empty($rs)){
                        $status = false;
                        $data = [];
                        $msg = 'No permission found';
                        return self::response($status, $msg, $data);
                    }
                }
                GroupPermission::deleteByIdGroup($group->id);
                foreach ($permissions as $permission) {
                    $group_permission = new GroupPermission(['id_group' => $group->id, 'action' => $permission['name']]);
                    $group_permission->save();
                }
            }else{
                $status = false;
                $msg = 'No group found';
            }

        }
        return $this->response($status, $msg, $data);
    }

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function responseList(Request $request)
    {
        if($request->user->id_group == 1){
            return $this->response(true, 'successfully', Group::all()->toArray());
        }else{
            $groups = Group::where('id', '!=', 1)->get()->toArray();
            return $this->response(true, 'successfully', ($groups) ? $groups : []);
        }
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Request $request)
    {
        $data = Group::where('id', $request->id)->with('permission')->first()->toArray();
        return $this->response($data ? true: false, $data ? 'successfully': 'no group found', $data);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function remove(Request $request)
    {
        $status = false;
        if(Group::find($request->id)->delete() && GroupPermission::deleteByIdGroup($request->id)) $status = true;

        return $this->response($status);
    }
}
