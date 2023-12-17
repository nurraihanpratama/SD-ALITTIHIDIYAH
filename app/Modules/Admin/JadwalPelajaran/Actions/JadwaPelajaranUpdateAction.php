<?php

namespace App\Modules\Admin\JadwalPelajaran\Actions;

class JadwalPelajaranUpdateAction
{
    public function update($request, $id)
    {
        dd($request->all(), $id);
    }
}