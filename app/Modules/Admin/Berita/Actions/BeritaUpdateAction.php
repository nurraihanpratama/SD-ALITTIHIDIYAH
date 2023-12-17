<?php

namespace App\Modules\Admin\Berita\Actions;

use App\Models\TblBerita;
use Illuminate\Support\Facades\DB;

class BeritaUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataBerita = getValidatedData(new TblBerita, $request->toArray());
            DB::transaction(function() use($dataBerita, $id){
                $tblBerita = TblBerita::find($id);
                dd($dataBerita);
                $tblBerita::update($dataBerita);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}