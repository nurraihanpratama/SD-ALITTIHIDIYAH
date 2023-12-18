<?php

namespace App\Modules\Admin\Kelas\Actions;

use App\Models\TblKelas;
use Illuminate\Support\Facades\DB;

class KelasStoreAction
{
    public function store($request)
    {
        try {
            $dataKelas = getValidatedData(new TblKelas, $request->toArray());
            DB::transaction(function() use($dataKelas){
                // dd($dataKelas);
                TblKelas::create($dataKelas);
            });

            return back()->withFlash('Berhasil Mendaftarkan Kelas Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}