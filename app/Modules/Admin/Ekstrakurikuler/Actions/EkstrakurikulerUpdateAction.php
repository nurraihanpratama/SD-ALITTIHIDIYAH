<?php

namespace App\Modules\Admin\Ekstrakurikuler\Actions;

use App\Models\TblEkstrakurikuler;
use Illuminate\Support\Facades\DB;

class EkstrakurikulerUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataEkstrakurikuler = getValidatedData(new TblEkstrakurikuler(), $request->toArray());
            DB::transaction(function() use($dataEkstrakurikuler, $id){
                // dd($dataEkstrakurikuler);
                $tblEkstrakurikuler = TblEkstrakurikuler::find($id);

                $tblEkstrakurikuler->update($dataEkstrakurikuler);
            });

            return back()->withFlash('Berhasil Mengubah Data Ekstrakurikuler ');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}