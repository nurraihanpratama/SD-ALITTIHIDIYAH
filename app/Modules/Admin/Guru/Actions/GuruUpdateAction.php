<?php

namespace App\Modules\Admin\Guru\Actions;

use App\Models\TblGuru;
use Illuminate\Support\Facades\DB;

class GuruUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataGuru = getValidatedData(new TblGuru, $request->toArray());
            DB::transaction(function() use($dataGuru, $id){
                // dd($dataGuru);
                $tblGuru = TblGuru::find($id);
                $tblGuru->update($dataGuru);
            });

            return back()->withFlash('Berhasil Mengubah Data Guru ');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}