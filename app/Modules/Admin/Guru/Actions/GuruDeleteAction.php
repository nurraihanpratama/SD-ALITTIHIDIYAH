<?php

namespace App\Modules\Admin\Guru\Actions;

use App\Models\TblGuru;
use Illuminate\Support\Facades\DB;

class GuruDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblGuru = TblGuru::findOrFail($id);
                $this->data = $tblGuru;
                $tblGuru->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Guru ' . $this->data->nama_guru ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}