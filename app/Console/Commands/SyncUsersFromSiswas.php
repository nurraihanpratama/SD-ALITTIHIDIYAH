<?php

namespace App\Console\Commands;

use App\Models\TblSiswa;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Hash;
use Ramsey\Uuid\Uuid;

class SyncUsersFromSiswas extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'sync:sync-users-from-siswas';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $siswas = TblSiswa::all();

        foreach ($siswas as $siswa) {
            // dd($siswa);

        $namaSiswa = $siswa->nama_siswa;
        $kata = explode(' ', $namaSiswa);
                
        // Mengambil dua kata pertama dan menggabungkannya kembali
        $namaPendek = implode(' ', array_slice($kata, 0, 2));
                
        $username = strtolower(str_replace(' ', '', $namaPendek));
        $email = $username . '@alittihadiya.com';

            // Check if the username is already taken
            if (User::where('username', $username)->exists()) {
            // If taken, append the third word to the username
            $namaPendek = implode(' ', array_slice($kata, 0, 3));
            $username = strtolower(str_replace(' ', '', $namaPendek));
            $email = $username . '@alittihadiya.com';
            }

            try {
                           // Pastikan username dan email belum ada sebelum membuat user
            if (!User::where('username', $username)->exists() && !User::where('email', $email)->exists()) {
                $user = new User([
                    'uuid' => Uuid::uuid4(),
                    'username' => $username,
                    'email' => $email,
                    'password' => Hash::make('12345678'),
                    'email_verified_at' => Carbon::now(),
                    'role' => 'siswa'
                    // Tambahkan field lain sesuai kebutuhan
                ]);

                $user->save();

                // Tambahkan UUID ke user_id di tbl_siswas
                $siswa->user_id = $user->uuid;
                $siswa->save();
                $this->info("User {$username} synced successfully.");
            }   else {
                    $this->info("User {$username} already exists.");
                }
            } catch (\Exception $e) {
                $this->error("Error syncing user for {$namaSiswa}: " . $e->getMessage());
            }
        }

        $this->info('Users to Siswa synced successfully.');
    }
}
