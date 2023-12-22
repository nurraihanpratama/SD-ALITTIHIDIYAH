<?php

namespace App\Modules\Admin\BidangStudi\Actions;

use App\Models\TblBidangStudi;
use Illuminate\Support\Facades\DB;

class BidangStudiUpdateAction
{
    public function update($request, $id)
    {
        try {
            $dataBidangStudi = getValidatedData(new TblBidangStudi, $request->toArray());
            DB::transaction(function() use($dataBidangStudi, $id){
                $tbl_BidangStudi = TblBidangStudi::find($id);
                $tbl_BidangStudi->update($dataBidangStudi);
            });

            return back()->withFlash('Berhasil Mengubah Bidang Studi');
        } catch (\Throwable $th) {
            dd($th);
        }
    }   
}