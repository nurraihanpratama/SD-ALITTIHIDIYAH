<?php

namespace App\Modules\Admin\Siswa\Actions;

use App\Models\DataAgama;
use App\Models\DataStatus;
use App\Models\JenisKelamin;
use App\Models\TblKelas;

class SiswaCreateAction
{
    public function options()
    {
        $kelas = TblKelas::select('id_kelas as id', 'nama as name')->get();
        $status = DataStatus::get();
        $jk = JenisKelamin::get();
        $agama = DataAgama::get();

        $options = compact('kelas', 'status','agama','jk');

        return $options;
    }
}