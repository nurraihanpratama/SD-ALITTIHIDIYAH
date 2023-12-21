<?php

namespace App\Modules\Admin\Fasilitas\Actions;

use App\Models\TblFasilitas;
use Illuminate\Support\Facades\DB;

class FasilitasDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblFasilitas = TblFasilitas::findOrFail($id);
                $this->data = $tblFasilitas;
                $tblFasilitas->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data fasilitas ' .$this->data->nama_fasilitas ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}