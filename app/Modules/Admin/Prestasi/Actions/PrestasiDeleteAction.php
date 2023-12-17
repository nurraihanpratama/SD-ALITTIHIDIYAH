<?php

namespace App\Modules\Admin\Pegawai\Actions;

class PegawaiDeleteAction
{
    public function delete($request, $id)
    {
        dd($request->all(), $id);
    }
}