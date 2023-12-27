<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);

        User::create([
            'uuid' => fake()->unique()->uuid(),
            'username' => 'admin',
            'password' => Hash::make('12345678'),
            'email' => 'admin@test.com',
            'email_verified_at' => now(),
            'role' => 'admin',
        ]);

        User::create([
            'uuid' => fake()->unique()->uuid(),
            'username' => 'guru',
            'password' => Hash::make('12345678'),
            'email' => 'guru@test.com',
            'email_verified_at' => now(),
            'role' => 'guru',
        ]);

        User::create([
            'uuid' => fake()->unique()->uuid(),
            'username' => 'siswa',
            'password' => Hash::make('12345678'),
            'email' => 'siswa@test.com',
            'email_verified_at' => now(),
            'role' => 'siswa',
        ]);

    }
}
