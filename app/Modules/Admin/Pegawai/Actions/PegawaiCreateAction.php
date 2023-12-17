<?php

namespace App\Modules\Admin\Pegawai\Actions;

use App\Models\DataStatus;
use App\Models\JenisKelamin;

class PegawaiCreateAction
{
    public function options()
    {
        $jk = JenisKelamin::get();
        $status = DataStatus::get();

        $options = compact('jk','status');
        return $options;
    }
}