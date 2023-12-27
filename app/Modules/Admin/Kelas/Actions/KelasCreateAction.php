<?php

namespace App\Modules\Admin\Kelas\Actions;

use App\Models\TblGuru;
use App\Models\TblTahunAjaran;

class KelasCreateAction
{
    public function options()
    {
        $gurus = TblGuru::select('id_guru as id', 'nama_guru as name')->get();

        $tahun_ajaran = TblTahunAjaran::get();
        $options = compact('gurus', 'tahun_ajaran');

        return $options;
    }
}