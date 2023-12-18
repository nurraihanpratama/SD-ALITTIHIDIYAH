<?php

namespace App\Modules\Admin\Guru\Actions;

use App\Models\TblGuru;
use Illuminate\Support\Facades\DB;

class GuruStoreAction 
{
    public function store($request)
    {
        try {
            $dataGuru = getValidatedData(new TblGuru, $request->toArray());
            DB::transaction(function() use($dataGuru){
                // dd($dataGuru);
                TblGuru::create($dataGuru);
            });

            return back()->withFlash('Berhasil Mendaftarkan Data Guru Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}