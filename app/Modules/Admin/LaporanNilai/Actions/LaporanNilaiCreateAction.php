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

        $mapels = TblBidangStudi::with(['gurus'])->get();

        foreach($mapels as $mapel){
            $mapel->gurus;
        }

        $options = compact('gurus', 'mapels');

        return $options;
    }
}