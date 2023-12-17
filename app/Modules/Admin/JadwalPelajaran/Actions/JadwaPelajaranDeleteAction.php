<?php

namespace App\Modules\Admin\JadwalPelajaran\Actions;

class JadwalPelajaranDeleteAction
{
    public function delete($request, $id)
    {
        dd($request->all(), $id);
    }
}