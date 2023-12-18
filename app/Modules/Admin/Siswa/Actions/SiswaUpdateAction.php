<?php

namespace App\Modules\Admin\Siswa\Actions;

use App\Models\TblSiswa;
use Illuminate\Support\Facades\DB;

class SiswaUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataSiswa = getValidatedData(new TblSiswa(), $request->toArray());
            DB::transaction(function() use($dataSiswa, $id){
                // dd($dataSiswa);
                $tblSiswa = TblSiswa::find($id);
                $tblSiswa->update($dataSiswa);
            });

            return back()->withFlash('Berhasil Mengubah data Siswa');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}