<?php

namespace App\Modules\Admin\LaporanNilai\Actions;

use App\Models\TblBidangStudi;
use App\Models\TblGuru;

use function Laravel\Prompts\select;

class LaporanNilaiCreateAction
{
    public function options()
    {
        $gurus = TblGuru::with(['bidangStudis'])->get();

        $mapel = TblBidangStudi::with(['gurus'])->get();
        $options = compact('gurus', 'mapel');

        return $options;
    }
}