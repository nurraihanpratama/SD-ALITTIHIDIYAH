<?php

namespace App\Modules\Admin\Pegawai\Tables;

use App\Models\TblPegawai;
use App\Modules\Admin\Pegawai\Resources\PegawaiResource;

class PegawaiDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblPegawai::query()
        ->with(['status','jk'])
        ->withSearch($search)
        ->paginate(15)
        ->appends([
            'search' => $search,
        ]);

        $collection = PegawaiResource::collection($data);

        return $collection;
    }
}