<?php

namespace App\Modules\Admin\LaporanNilai\Actions;

use App\Models\TblGuru;

use function Laravel\Prompts\select;

class LaporanNilaiCreateAction
{
    public function options()
    {
        $gurus = TblGuru::with(['bidangStudis'])->get();

        $options = compact('gurus');

        return $options;
    }
}