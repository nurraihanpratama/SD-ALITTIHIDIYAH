<?php

namespace App\Modules\Admin\Prestasi\Actions;

use App\Models\TblPrestasi;
use Illuminate\Support\Facades\DB;

class PrestasiUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataPrestasi = getValidatedData(new TblPrestasi, $request->toArray());
            DB::transaction(function() use($dataPrestasi, $id){
                // dd($dataPrestasi);
                $tblPrestasi = TblPrestasi::find($id);
                $tblPrestasi->update($dataPrestasi);
            });

            return back()->withFlash('Berhasil Mengubah data Prestasi');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}