<?php

namespace App\Modules\Admin\BidangStudi\Actions;

use App\Models\TblBidangStudi;
use Illuminate\Support\Facades\DB;

class BidangStudiDeleteAction
{
    public $data;
    public function delete($request, $id)
    {
        try {
            DB::transaction(function() use($id){
                // dd($dataKelas);
                $tblBidangStudi = TblBidangStudi::findOrFail($id);
                $this->data = $tblBidangStudi;
                $tblBidangStudi->delete();
            });

            return response()->json(['success' => true, 'message' => 'Berhasil Menghapus data Bidang Studi ' ]);
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}
