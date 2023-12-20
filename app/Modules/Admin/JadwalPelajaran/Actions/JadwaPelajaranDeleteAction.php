<?php

namespace App\Modules\Admin\JadwalPelajaran\Actions;

use App\Models\TblRoster;
use Illuminate\Support\Facades\DB;

class JadwalPelajaranDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblJadwalPelajaran = TblRoster::findOrFail($id);
                $this->data = $tblJadwalPelajaran;
                $tblJadwalPelajaran->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Jadwal Pelajaran ' ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}