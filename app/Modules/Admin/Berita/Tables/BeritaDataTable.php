<?php

namespace App\Modules\Admin\Berita\Tables;

use App\Models\TblBerita;
use App\Modules\Admin\Berita\Resources\BeritaResource;

class BeritaDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblBerita::query()
        ->withSearch($search)
        ->paginate(15)
        ->appends([
            'search' => $search,
        ]);

        $collection = BeritaResource::collection($data);

        return $collection;
    }
}