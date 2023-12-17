<?php

namespace App\Modules\Admin\BidangStudi\Actions;

use App\Models\TblBidangStudi;
use Illuminate\Support\Facades\DB;

class BidangStudiStoreAction 
{
    public function store($request)
    {
        try {
            $dataBidangStudi = getValidatedData(new TblBidangStudi, $request->toArray());
            DB::transaction(function() use($dataBidangStudi){
                dd($dataBidangStudi);
                TblBidangStudi::create($dataBidangStudi);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}