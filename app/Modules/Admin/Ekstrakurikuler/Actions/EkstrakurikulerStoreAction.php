<?php

namespace App\Modules\Admin\Ekstrakurikuler\Actions;

use App\Models\TblEkstrakurikuler;
use Illuminate\Support\Facades\DB;

class EkstrakurikulerStoreAction 
{
    public function store($request)
    {
        try {
            $dataEkstrakurikuler = getValidatedData(new TblEkstrakurikuler, $request->toArray());
            DB::transaction(function() use($dataEkstrakurikuler){
                dd($dataEkstrakurikuler);
                TblEkstrakurikuler::create($dataEkstrakurikuler);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}