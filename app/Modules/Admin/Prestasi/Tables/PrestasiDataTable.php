<?php

namespace App\Modules\Admin\Prestasi\Tables;

use App\Models\TblPrestasi;
use App\Modules\Admin\Prestasi\Resources\PrestasiResource;

class PrestasiDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblPrestasi::query()
                ->withSearch($search)
                ->paginate(15)
                ->appends([
                    'search' => $search,
                ]);

        $collection = PrestasiResource::collection($data);

        return $collection;
    }
}