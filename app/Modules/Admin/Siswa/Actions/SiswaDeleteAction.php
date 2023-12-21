<?php

namespace App\Modules\Admin\Siswa\Actions;

use App\Models\TblSiswa;
use Illuminate\Support\Facades\DB;

class SiswaDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblSiswa = TblSiswa::findOrFail($id);
                $this->data = $tblSiswa;
                $tblSiswa->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Siswa ' . $this->data->nama_siswa ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}