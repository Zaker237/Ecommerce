<?php

namespace Database\Seeders;

use App\Models\CustomerAddress;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CustomerAddressSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        CustomerAddress::create([
            'type' => 'shipping',
            'address1' => 'Admin',
            'address2' => '004917258558963',
            'city' => 'yaounde',
            'state' => 'Cameroon',
            'zipcode' => 237,
            'country_code' => 'cm',
            'customer_id' => 1,
            'created_at' => now(),
            'updated_at' => now()
        ]);

        CustomerAddress::create([
            'type' => 'billing',
            'address1' => 'Admin',
            'address2' => '004917258558963',
            'city' => 'yaounde',
            'state' => 'Cameroon',
            'zipcode' => 237,
            'country_code' => 'cm',
            'customer_id' => 1,
            'created_at' => now(),
            'updated_at' => now()
        ]);
    }
}