<?php

namespace App\Modules\Admin\Fasilitas\Tables;

use App\Models\TblFasilitas;
use App\Modules\Admin\Fasilitas\Resources\FasilitasResource;

class FasilitasDataTable
{
    public function generate($request)
    {
        $data = TblFasilitas::query()
                ->paginate(15);

        $collection = FasilitasResource::collection($data);

        return $collection;
    }
}