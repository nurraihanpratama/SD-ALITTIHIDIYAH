<?php

namespace App\Modules\Admin\Berita\Tables;

use App\Models\TblBerita;
use App\Modules\Admin\Berita\Resources\BeritaResource;

class BeritaDataTable
{
    public function generate($request)
    {
        $data = TblBerita::query()
                ->paginate(15);

        $collection = BeritaResource::collection($data);

        return $collection;
    }
}