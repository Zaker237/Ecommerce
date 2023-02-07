<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            AdminUserSeeder::class,
            CustomerSeeder::class,
            ProductSeeder::class,
            CountrySeeder::class
        ]);
        // \App\Models\User::factory(10)->create();
    }
}
