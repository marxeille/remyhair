<?php

use Illuminate\Database\Seeder;

class CustomerTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('customer')->delete();
        $faker = Faker\Factory::create();
        for ($i=0; $i < 100; $i++){
            DB::table('customer')->insert([
                'id_employee' => 1,
                'full_name'  => $faker->name,
                'phone' => $faker->phoneNumber,
                'is_special_customer' => $faker->randomElement([0,1]),
                'email' => $faker->email,
                'status' => $faker->randomElement([0, 1]),
                'type' => $faker->randomElement(['Normal', 'Best', 'Good']),
            ]);
        }
    }
}
