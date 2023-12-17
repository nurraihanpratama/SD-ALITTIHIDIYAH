<?php

namespace App\Modules\Admin\Fasilitas\Actions;

use App\Models\TblFasilitas;
use Illuminate\Support\Facades\DB;

class FasilitasStoreAction 
{
    public function store($request)
    {
        try {
            $dataFasilitas = getValidatedData(new TblFasilitas, $request->toArray());
            DB::transaction(function() use($dataFasilitas){
                dd($dataFasilitas);
                TblFasilitas::create($dataFasilitas);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}