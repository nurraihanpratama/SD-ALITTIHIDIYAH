<?php

namespace App\Modules\Admin\Berita\Actions;

use App\Models\TblAkun;

class BeritaCreateAction
{
    public function options()
    {
        $akun = TblAkun::get();

        $options = compact('akun');

        return $options;
    }
}