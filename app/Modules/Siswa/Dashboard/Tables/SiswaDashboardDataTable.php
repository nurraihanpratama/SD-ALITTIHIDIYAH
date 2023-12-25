<?php

namespace App\Modules\Siswa\Dashboard\Tables;

use App\Models\viewRosterKelas;
use App\Modules\Siswa\Dashboard\Resources\SiswaDashboardResource;
use Illuminate\Http\Request;

class SiswaDashboardDataTable
{
    public function generate()
    {
        $data = viewRosterKelas::query()
                ->paginate(15);

        $collection = SiswaDashboardResource::collection($data);

        return $collection;
    }
}
