<?php

namespace App\Modules\Admin\JadwalPelajaran\Tables;

use App\Models\TblRoster;
use App\Modules\Admin\JadwalPelajaran\Resources\JadwalPelajaranResource;

class JadwalPelajaranDataTable
{
    public function generate($request)
    {
        $data = TblRoster::query()
                ->paginate(15);

        $collection = JadwalPelajaranResource::collection($data);

        return $collection;
    }
}