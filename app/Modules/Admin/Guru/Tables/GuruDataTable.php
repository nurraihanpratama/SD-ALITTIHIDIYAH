<?php

namespace App\Modules\Admin\Guru\Tables;

use App\Models\TblGuru;
use App\Modules\Admin\Guru\Resources\GuruResource;

class GuruDataTable
{
    public function generate($request)
    {
        $data = TblGuru::query()
                ->paginate(15);

        $collection = GuruResource::collection($data);

        return $collection;
    }
}