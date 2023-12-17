<?php

namespace App\Modules\Admin\Berita\Actions;

use App\Models\TblBerita;
use Illuminate\Support\Facades\DB;

class BeritaStoreAction
{
    public function store($request)
    {
        try {
            $dataBerita = getValidatedData(new TblBerita, $request->toArray());
            DB::transaction(function() use($dataBerita){
                dd($dataBerita);
                TblBerita::create($dataBerita);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}