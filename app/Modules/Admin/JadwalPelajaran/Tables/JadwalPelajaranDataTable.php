<?php

namespace App\Modules\Admin\JadwalPelajaran\Tables;

use App\Models\TblGuru;
use App\Models\TblRoster;
use App\Modules\Admin\JadwalPelajaran\Resources\JadwalPelajaranResource;

class JadwalPelajaranDataTable
{
    public function generate($request)
    {
        // dd(TblGuru::with(['bidangStudis'])->take(10)->get());
        $search = $request->get('search');
        $data = TblRoster::query()
                ->with(['kelas','guru.bidangStudis'])
                ->withSearch($search)
                ->paginate(15)
                ->appends([
                    'search' => $search,
                ]);

        $collection = JadwalPelajaranResource::collection($data);

        return $collection;
    }
}