<?php

namespace App\Modules\Admin\Prestasi\Actions;

use App\Models\TblPrestasi;
use Illuminate\Support\Facades\DB;

class PrestasiDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblPrestasi = TblPrestasi::findOrFail($id);
                $this->data = $tblPrestasi;
                $tblPrestasi->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Prestasi ' .$this->data->nama_prestasi ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}