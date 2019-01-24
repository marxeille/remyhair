<?php

use Illuminate\Database\Seeder;

class GroupTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('group')->delete();
        DB::table('group_permission')->delete();

        $admin = \App\Models\Employee::where('email', 'admin@remyhair.vn')->first();
        $group = \App\Models\Group::find(1);
        if(!$group) {
            $group = new \App\Models\Group();
            $group->id = 1;
            $group->name = 'Admin';
            $group->save();
        }else{
            \DB::insert("insert into group (id, name) values (1, 'admin')");
        }

        $admin->id_group = 1;
        $admin->save();

        $actions = \App\Models\GroupPermission::getRoles();

        foreach ($actions as $action) {
            $permission = new \App\Models\GroupPermission();
            $permission->id_group = $group->id;
            $permission->action = $action['name'];
            $permission->save();
        }
    }
}
