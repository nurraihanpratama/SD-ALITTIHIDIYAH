<?php

namespace App\Modules\Admin\JadwalPelajaran\Tables;

use App\Models\TblRoster;
use App\Modules\Admin\JadwalPelajaran\Resources\JadwalPelajaranResource;

class JadwalPelajaranDataTable
{
    public function generate($request)
    {
        $search = $request->get('search');
        $data = TblRoster::query()
                ->with(['kelas', 'guru'])
                ->withSearch($search)
                ->paginate(15)
                ->appends([
                    'search' => $search,
                ]);

        $collection = JadwalPelajaranResource::collection($data);

        return $collection;
    }
}