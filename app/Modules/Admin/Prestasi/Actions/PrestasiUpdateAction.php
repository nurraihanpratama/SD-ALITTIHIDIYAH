<?php

namespace App\Modules\Admin\Prestasi\Actions;

class PrestasiUpdateAction
{
    public function update($request, $id)
    {
        dd($request->all(), $id);
    }
}