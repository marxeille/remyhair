<?php

use Illuminate\Database\Seeder;
use Carbon\Carbon;

class SupportTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('support')->delete();
        $faker = Faker\Factory::create();
        $customer = \App\Models\Customer::select('id')->get()->toArray();
        $employee = \App\Models\Employee::select('id')->get()->toArray();
        $customer = array_column($customer, 'id');
        $employee = array_column($employee, 'id');

        for ($i =0; $i <=10; $i++){
            DB::table('invoice_status')->insert([
                'name' => $faker->streetName,
            ]);
        }
        for($i =0; $i <=6; $i++){
            DB::table('payment')->insert([
                'name' => $faker->creditCardType,
            ]);
        }
        $id_invoice = \App\Models\InvoiceStatus::select('id')->get()->toArray();
        $id_invoice = array_column($id_invoice, 'id');
        $id_payment = \App\Models\Payment::select('id')->get()->toArray();
        $id_payment = array_column($id_payment, 'id');


        for ($i =0; $i <=100; $i++){
            DB::table('support')->insert([
                'id_customer' => $faker->randomElement($customer),
                'id_employee' =>  $faker->randomElement($employee),
                'id_invoice_status' => $faker->randomElement($id_invoice),
                'invoice_number' => $faker->randomNumber(1),
                'support_time' => $faker->randomNumber(1),
                'id_payment' => $faker->randomElement($id_payment),
                'total_kg' => $faker->randomNumber(2),
                'source' => $faker->countryCode,
                'complain' => $faker->text(255),
            ]);
        }

        $support = \App\Models\Support::select('id')->get()->toArray();
        $support = array_column($support, 'id');
        for ($i =0; $i <=100; $i++){
            DB::table('note')->insert([
                'content' => $faker->text(255),
                'id_support' => $faker->randomElement($support),
            ]);
        }

    }
}
