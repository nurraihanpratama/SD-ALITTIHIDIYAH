<?php

namespace App\Modules\Admin\Ekstrakurikuler\Tables;

use App\Models\TblEkstrakurikuler;
use App\Modules\Admin\Ekstrakurikuler\Resources\EkstrakurikulerResource;

class EkstrakurikulerDataTable
{
    public function generate($request)
    {
        $search = $request->get('searcg');
        $data = TblEkstrakurikuler::query()
        ->withSearch($search)
        ->paginate(15)
        ->appends([
            'search' => $search,
        ]);

        $collection = EkstrakurikulerResource::collection($data);

        return $collection;
    }
}