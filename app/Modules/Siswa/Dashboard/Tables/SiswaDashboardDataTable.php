<?php

namespace App\Modules\Siswa\Dashboard\Tables;

use App\Models\viewRosterKelas;
use App\Modules\Siswa\Dashboard\Resources\SiswaDashboardResource;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Request;

class SiswaDashboardDataTable extends JsonResource
{
    public function generate()
    {
        $data = viewRosterKelas::query()
                ->paginate(15);

        $collection = SiswaDashboardResource::collection($data);

        return $collection;
    }
}
