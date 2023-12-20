<?php

namespace App\Modules\Admin\Berita\Actions;

use App\Models\TblBerita;
use Illuminate\Support\Facades\DB;

class BeritaDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblBerita = TblBerita::findOrFail($id);
                $this->data = $tblBerita;
                $tblBerita->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Berita ']);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}
