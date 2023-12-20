<?php

namespace App\Modules\Admin\Prestasi\Actions;

use App\Models\TblPrestasi;
use Illuminate\Support\Facades\DB;

class PrestasiStoreAction 
{
    public function store($request)
    {
        try {
            $dataPrestasi = getValidatedData(new TblPrestasi, $request->toArray());
            DB::transaction(function() use($dataPrestasi){
                // dd($dataPrestasi);
                TblPrestasi::create($dataPrestasi);
            });

            return back()->withFlash('Berhasil Mendaftarkan Prestasi Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}