<?php

namespace App\Modules\Admin\Kelas\Tables;

use App\Models\TblKelas;
use App\Modules\Admin\Kelas\Resources\KelasResource;

class KelasDataTable
{
    public function generate($request)
    {
        $data = TblKelas::query()
                ->with(['guru'])
                ->paginate(15);

        $collection = KelasResource::collection($data);

        return $collection;
    }
}