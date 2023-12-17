<?php

namespace App\Modules\Admin\Guru\Tables;

use App\Models\TblGuru;
use App\Modules\Admin\Guru\Resources\GuruResource;

class GuruDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblGuru::query()
                ->withSearch($search)
                ->paginate(15)
                ->appends([
                    'search' => $search,
                ]);

        $collection = GuruResource::collection($data);

        return $collection;
    }
}