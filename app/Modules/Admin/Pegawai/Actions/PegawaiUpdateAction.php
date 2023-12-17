<?php

namespace App\Modules\Admin\Pegawai\Actions;

class PegawaiUpdateAction
{
    public function update($request, $id)
    {
        dd($request->all(), $id);
    }
}