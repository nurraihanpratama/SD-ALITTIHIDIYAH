<?php

namespace App\Modules\Siswa\DataNilai\Tables;

use App\Models\TblBidangStudi;
use App\Models\TblGuru;
use App\Models\TblNilai;
use App\Models\TblSiswa;
use App\Modules\Siswa\DataNilai\Resources\DataNilaiResource;

class DataNilaiDataTable
{
    public function generate($request)
    {   
        $nisn = 117461542;

        $data = TblBidangStudi::whereHas('gurus.nilai.siswa', function ($query) {
            $query->where('nisn', getIdUser());
        })
        ->with(['gurus.nilai.siswa', 'gurus.nilai.bidangStudi', 'gurus.kelas'])
        ->paginate();
        // dd($data);

        $collection = DataNilaiResource::collection($data);

        return $collection;
    }
}