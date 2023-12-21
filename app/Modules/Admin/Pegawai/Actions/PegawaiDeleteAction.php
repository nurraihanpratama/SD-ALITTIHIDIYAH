<?php

namespace App\Modules\Admin\Pegawai\Actions;

use App\Models\TblPegawai;
use Illuminate\Support\Facades\DB;

class PegawaiDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblPegawai = TblPegawai::findOrFail($id);
                $this->data = $tblPegawai;
                $tblPegawai->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Pegawai ' . $this->data->nama_pegawai ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}