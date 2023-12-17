<?php

namespace App\Modules\Admin\Siswa\Actions;

use App\Models\TblSiswa;
use Illuminate\Support\Facades\DB;

class SiswaStoreAction
{
    public function store($request)
    {
        try {
            $dataSiswa = getValidatedData(new TblSiswa, $request->toArray());
            DB::transaction(function() use($dataSiswa){
                TblSiswa::create($dataSiswa);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}