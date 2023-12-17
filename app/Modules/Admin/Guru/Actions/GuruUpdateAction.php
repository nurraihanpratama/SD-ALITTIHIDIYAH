<?php

namespace App\Modules\Admin\Guru\Actions;

class GuruUpdateAction
{
    public function update($request, $id)
    {
        dd($request->all(), $id);
    }
}