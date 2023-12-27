<?php

namespace App\Console\Commands;

use App\Models\TblGuru;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Hash;
use Ramsey\Uuid\Uuid;

class SyncUsersFromGurus extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'sync:sync-users-from-gurus';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Sync Users from Gurus table';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $gurus = TblGuru::all();

        foreach ($gurus as $guru) {
            // dd($guru);
            $username = strtolower(str_replace(' ', '', $guru->nama_guru));
            $email = $username . '@alittihadiya.com'; // Sesuaikan dengan aturan pembuatan email Anda

            // Pastikan username dan email belum ada sebelum membuat user
            if (!User::where('username', $username)->exists() && !User::where('email', $email)->exists()) {
                $user = new User([
                    'uuid' => Uuid::uuid4(),
                    'username' => $username,
                    'email' => $email,
                    'password' => Hash::make('12345678'),
                    'email_verified_at' => Carbon::now(),
                    'role' => 'guru'
                    // Tambahkan field lain sesuai kebutuhan
                ]);

                $user->save();

                // Tambahkan UUID ke user_id di tbl_gurus
                $guru->user_id = $user->uuid;
                $guru->save();
            }
        }

        $this->info('Users synced successfully.');
    }
}
