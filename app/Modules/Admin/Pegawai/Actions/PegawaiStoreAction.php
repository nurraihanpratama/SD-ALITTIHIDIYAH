<?php

namespace App\Modules\Admin\Pegawai\Actions;

use App\Models\TblPegawai;
use Illuminate\Support\Facades\DB;

class PegawaiStoreAction 
{
    public function store($request)
    {
        try {
            $dataPegawai = getValidatedData(new TblPegawai, $request->toArray());
            DB::transaction(function() use($dataPegawai){
                dd($dataPegawai);
                TblPegawai::create($dataPegawai);

            });

            return back()->withFlash('Berhasil Mendaftarkan Pegawai Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}