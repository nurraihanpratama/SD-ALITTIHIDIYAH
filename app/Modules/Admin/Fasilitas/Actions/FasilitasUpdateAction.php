<?php

namespace App\Modules\Admin\Fasilitas\Actions;

use App\Models\TblFasilitas;
use Illuminate\Support\Facades\DB;

class FasilitasUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataFasilitas = getValidatedData(new TblFasilitas(), $request->toArray());
            DB::transaction(function() use($dataFasilitas, $id){
                // dd($dataFasilitas);
                $tblFasilitas = TblFasilitas::find($id);
                $tblFasilitas->update($dataFasilitas);
            });

            return back()->withFlash('Berhasil Mengubah Data Fasilitas ');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}