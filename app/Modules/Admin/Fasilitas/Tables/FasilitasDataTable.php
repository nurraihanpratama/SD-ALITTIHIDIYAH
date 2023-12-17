<?php

namespace App\Modules\Admin\Fasilitas\Tables;

use App\Models\TblFasilitas;
use App\Modules\Admin\Fasilitas\Resources\FasilitasResource;

class FasilitasDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblFasilitas::query()
                ->withSearch($search)
                ->paginate(15)
                ->appends([
                    'search' => $search,
                ]);

        $collection = FasilitasResource::collection($data);

        return $collection;
    }
}