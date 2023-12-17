<?php

namespace App\Modules\Admin\Guru\Actions;

use App\Models\DataStatus;
use App\Models\KeteranganGuru;

class GuruCreateAction
{
    public function options()
    {
        $status = DataStatus::get();

        $ket_guru = KeteranganGuru::get();

        $options = compact('status', 'ket_guru');

        return $options;
    }
}