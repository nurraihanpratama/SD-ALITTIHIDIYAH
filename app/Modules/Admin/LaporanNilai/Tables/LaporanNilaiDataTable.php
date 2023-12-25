<?php

namespace App\Modules\Admin\LaporanNilai\Tables;

use App\Models\TblLaporanNilai;
use App\Models\TblNilai;
use App\Models\TblSiswa;
use App\Modules\Admin\LaporanNilai\Resources\LaporanNilaiResource;

class LaporanNilaiDataTable
{
    public function generate($request)
    {
        $data = TblSiswa::query()
                ->with(['nilais' => function($q){
                    $q->with(['mapel', 'guru']);
                }])
                ->inhouse(getIdUser())
                ->paginate(15);

                // dd($data);
        $collection = LaporanNilaiResource::collection($data);

        return $collection;
    }
}