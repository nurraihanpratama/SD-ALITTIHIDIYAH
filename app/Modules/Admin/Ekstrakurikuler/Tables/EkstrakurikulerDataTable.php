<?php

namespace App\Modules\Admin\Ekstrakurikuler\Tables;

use App\Models\TblEkstrakurikuler;
use App\Modules\Admin\Ekstrakurikuler\Resources\EkstrakurikulerResource;

class EkstrakurikulerDataTable
{
    public function generate($request)
    {
        $data = TblEkstrakurikuler::query()
                ->paginate(15);

        $collection = EkstrakurikulerResource::collection($data);

        return $collection;
    }
}