<?php

namespace App\Modules\Siswa\Mapel\Tables;

use App\Models\TblGuru;
use App\Models\TblSiswa;
use App\Modules\Siswa\Mapel\Resources\MapelResource;

class MapelDataTable
{
    public function generate($request)
    {

        // dd(getIdGuru());
        $data = TblSiswa::query()
                ->with(['kelas','jk', 'status' , 'agama'])
                ->inhouse(getIdUser())
                ->paginate(15);
                // ->appends()

        $collection = MapelResource::collection($data);

        return $collection;
    }
}