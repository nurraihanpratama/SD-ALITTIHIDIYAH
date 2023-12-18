<?php

namespace App\Modules\Admin\Pegawai\Actions;

use App\Models\TblPegawai;
use Illuminate\Support\Facades\DB;

class PegawaiUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataPegawai = getValidatedData(new TblPegawai(), $request->toArray());
            DB::transaction(function() use($dataPegawai, $id){
                // dd($dataPegawai);
                $tblPegawai = TblPegawai::find($id);
                $tblPegawai->update($dataPegawai);
            });

            return back()->withFlash('Berhasil Mengubah data Pegawai');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}