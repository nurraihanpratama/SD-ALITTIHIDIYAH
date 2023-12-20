<?php

namespace App\Modules\Admin\LaporanNilai\Tables;

use App\Models\TblLaporanNilai;
use App\Models\TblNilai;
use App\Modules\Admin\LaporanNilai\Resources\LaporanNilaiResource;

class LaporanNilaiDataTable
{
    public function generate($request)
    {
        $data = TblNilai::query()
                ->with(['siswa','jenisNilai', 'mapel', 'guru'])
                ->paginate(15);

        $collection = LaporanNilaiResource::collection($data);

        return $collection;
    }
}