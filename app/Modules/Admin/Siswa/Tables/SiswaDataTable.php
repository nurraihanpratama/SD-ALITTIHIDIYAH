<?php

namespace App\Modules\Admin\Siswa\Tables;

use App\Models\TblSiswa;
use App\Modules\Admin\Siswa\Resources\SiswaResource;

class SiswaDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblSiswa::query()
        ->with(['kelas', 'status', 'jk'])
        ->withSearch($search)
        ->paginate(15)
        ->appends([
            'search' => $search,
        ]);

        $collection = SiswaResource::collection($data);

        return $collection;
    }
}