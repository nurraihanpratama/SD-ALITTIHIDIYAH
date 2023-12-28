<?php

namespace App\Modules\Admin\JadwalPelajaran\Tables;

use App\Models\TblKelas;
use App\Modules\Admin\JadwalPelajaran\Resources\JadwalPelajaranResource;
use Illuminate\Http\Request;

class KelasSelectionDataTable {
    public function __invoke(Request $request){

        $data = TblKelas::query()
                ->paginate(15);

        $collection = JadwalPelajaranResource::collection($data);
        return $collection;
    }
}