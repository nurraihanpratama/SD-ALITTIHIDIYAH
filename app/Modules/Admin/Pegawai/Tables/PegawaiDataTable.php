<?php

namespace App\Modules\Admin\Pegawai\Tables;

use App\Models\TblPegawai;
use App\Modules\Admin\Pegawai\Resources\PegawaiResource;

class PegawaiDataTable
{
    public function generate($request)
    {
        $data = TblPegawai::query()
                ->paginate(15);

        $collection = PegawaiResource::collection($data);

        return $collection;
    }
}