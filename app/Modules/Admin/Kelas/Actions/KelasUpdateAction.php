<?php

namespace App\Modules\Admin\Kelas\Actions;

use App\Models\TblKelas;
use Illuminate\Support\Facades\DB;

class KelasUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataKelas = getValidatedData(new TblKelas(), $request->toArray());
            DB::transaction(function() use($dataKelas, $id){
                // dd($dataKelas);
                $tblKelas = TblKelas::find($id);
                $tblKelas->update($dataKelas);
            });

            return back()->withFlash('Berhasil Mengubah data Kelas');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}