<?php

namespace App\Modules\Admin\JadwalPelajaran\Actions;

use App\Models\TblRoster;
use Illuminate\Support\Facades\DB;

class JadwalPelajaranStoreAction 
{
    public function store($request)
    {
        try {
            $dataJadwalPelajaran = getValidatedData(new TblRoster, $request->toArray());
            DB::transaction(function() use($dataJadwalPelajaran){
                dd($dataJadwalPelajaran);
                TblRoster::create($dataJadwalPelajaran);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}