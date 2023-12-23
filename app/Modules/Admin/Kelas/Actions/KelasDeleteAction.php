<?php

namespace App\Modules\Admin\Kelas\Actions;

use App\Models\TblKelas;
use Illuminate\Support\Facades\DB;

class KelasDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblKelas = TblKelas::findOrFail($id);
                $this->data = $tblKelas;
                $tblKelas->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Kelas ' . $this->data->nama ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}
