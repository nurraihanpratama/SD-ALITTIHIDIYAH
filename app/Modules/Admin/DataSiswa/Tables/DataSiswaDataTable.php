<?php

namespace App\Modules\Admin\DataSiswa\Tables;

use App\Models\TblGuru;
use App\Models\TblSiswa;
use App\Modules\Admin\DataSiswa\Resources\DataSiswaResource;

class DataSiswaDataTable
{
    public function generate($request)
    {

        // dd(getIdGuru());
        $data = TblSiswa::query()
                ->with(['kelas','jk', 'status' , 'agama'])
                ->inhouse(getIdGuru())
                ->paginate(15);
                // ->appends()

        $collection = DataSiswaResource::collection($data);

        return $collection;
    }
}