<?php

use Illuminate\Database\Seeder;
use Carbon\Carbon;

class EmployeeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('customer')->delete();
        DB::table('support')->delete();
        DB::table('employee')->delete();

        $faker = Faker\Factory::create();

        DB::table('employee')->insert([
            'name' => 'admin',
            'email' => 'admin@remyhair.vn',
            'password' => bcrypt('2eTE74ftZp'),
            'id_group' => 1,
            'date_of_birth' => Carbon::create('2000', '01', '01'),
            'join_date' => Carbon::create('2000', '01', '01'),
            'date_of_contract' => Carbon::create('2000', '01', '01'),
            'date_of_graduation' => Carbon::create('2000', '01', '01'),
            'address' => 'Vietnam',
            'phone' => '093295693',
            'facebook' => '',
            'education' => '',
            'school' => '',
            'major' => ''
        ]);
    }
}
