<?php

namespace App\Modules\Admin\Prestasi\Tables;

use App\Models\TblPrestasi;
use App\Modules\Admin\Prestasi\Resources\PrestasiResource;

class PrestasiDataTable
{
    public function generate($request)
    {
        $data = TblPrestasi::query()
                ->paginate(15);

        $collection = PrestasiResource::collection($data);

        return $collection;
    }
}