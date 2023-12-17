<?php

namespace App\Modules\Admin\Siswa\Tables;

use App\Models\TblSiswa;
use App\Modules\Admin\Siswa\Resources\SiswaResource;

class SiswaDataTable
{
    public function generate($request)
    {
        $data = TblSiswa::query()
        ->with(['kelas', 'status', 'jk'])
        ->paginate(15);

        $collection = SiswaResource::collection($data);

        return $collection;
    }
}