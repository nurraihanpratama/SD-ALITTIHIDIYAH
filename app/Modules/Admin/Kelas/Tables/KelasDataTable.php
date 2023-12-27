<?php

namespace App\Modules\Admin\Kelas\Tables;

use App\Models\TblKelas;
use App\Modules\Admin\Kelas\Resources\KelasResource;

class KelasDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblKelas::query()
                ->with(['guru', 'tahunAjaran', 'siswa'])
                ->withSearch($search)
                ->paginate(15)
                ->appends([
                    'search' => $search,
                ]);

        $collection = KelasResource::collection($data);

        return $collection;
    }
}