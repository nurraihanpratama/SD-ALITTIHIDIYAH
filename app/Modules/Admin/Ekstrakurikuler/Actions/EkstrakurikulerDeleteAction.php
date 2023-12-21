<?php

namespace App\Modules\Admin\Ekstrakurikuler\Actions;

use App\Models\TblEkstrakurikuler;
use Illuminate\Support\Facades\DB;

class EkstrakurikulerDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblEkstrakurikuler = TblEkstrakurikuler::findOrFail($id);
                $this->data = $tblEkstrakurikuler;
                $tblEkstrakurikuler->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Ekskul '.$this->data->nama_ekstrakurikuler ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}