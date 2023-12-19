<?php

namespace App\Modules\Siswa\DataNilai\Tables;

use App\Models\TblGuru;
use App\Models\TblNilai;
use App\Models\TblSiswa;
use App\Modules\Siswa\DataNilai\Resources\DataNilaiResource;

class DataNilaiDataTable
{
    public function generate($request)
    {

        // dd(getIdGuru());
        $data = TblNilai::query()
        ->with(['siswa','jenisNilai', 'mapel', 'guru'])
        ->paginate(15);

        $collection = DataNilaiResource::collection($data);

        return $collection;
    }
}