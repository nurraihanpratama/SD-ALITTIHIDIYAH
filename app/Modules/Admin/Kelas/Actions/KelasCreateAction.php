<?php

namespace App\Modules\Admin\Kelas\Actions;

use App\Models\TblGuru;

class KelasCreateAction
{
    public function options()
    {
        $gurus = TblGuru::select('id_guru', 'nama_guru')->get();

        $options = compact('gurus');

        return $options;
    }
}