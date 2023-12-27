<?php

namespace App\Modules\Admin\Guru\Actions;

use App\Models\TblGuru;
use App\Models\User;
use App\Modules\NewModels\Guru;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Ramsey\Uuid\Uuid;

class GuruStoreAction 
{
    public function store($request)
    {
        try {
            $dataGuru = getValidatedData(new TblGuru, $request->toArray());
            DB::transaction(function() use($dataGuru, $request){
                // dd($dataGuru);
                $username = strtolower(str_replace(' ', '', $request->nama_guru));
                $user = new User([
                    'uuid' => Uuid::uuid4(),
                    'username' => $username,
                    'email' =>  $username.'@alittihadiyah.com',
                    'role' => 'guru',
                    'password' => Hash::make('12345678'),
                    'status' => true,

                ]);
                $user->save();

                // $guru = new Guru();
                $dataGuru['user_id'] = $user->uuid;
                TblGuru::create($dataGuru);
            });

            return back()->withFlash('Berhasil Mendaftarkan Data Guru Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}