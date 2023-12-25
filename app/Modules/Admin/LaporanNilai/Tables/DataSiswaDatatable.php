<?php

namespace App\Modules\Admin\LaporanNilai\Tables;

use App\Models\TblGuru;
use App\Models\TblSiswa;
use App\Modules\Admin\LaporanNilai\Resources\LaporanNilaiResource;

class DataSiswaDataTable
{
    public function generate()
    {

        // dd(getIdGuru());
        $data = TblSiswa::query()
                ->with(['kelas','jk', 'status' , 'agama'])
                ->inhouse(getIdUser())
                ->get();
                // ->paginate(15);
                // ->appends()

        $collection = LaporanNilaiResource::collection($data);

        return $collection;
    }
}