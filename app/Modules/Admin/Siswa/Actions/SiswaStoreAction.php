<?php

namespace App\Modules\Admin\Siswa\Actions;

use App\Models\TblSiswa;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Ramsey\Uuid\Uuid;

class SiswaStoreAction
{
    public function store($request)
    {
        try {
            $dataSiswa = getValidatedData(new TblSiswa, $request->toArray());
            DB::transaction(function() use($dataSiswa, $request){

                $username = strtolower(str_replace(' ', '', $request->nama_siswa));
                $user = new User([
                    'uuid' => Uuid::uuid4(),
                    'username' => $username,
                    'email' =>  $username.'@alittihadiyah.com',
                    'role' => 'guru',
                    'password' => Hash::make('12345678'),
                    'status' => true,

                ]);
                $user->save();

                $dataSiswa['user_id'] = $user->uuid;
                TblSiswa::create($dataSiswa);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}