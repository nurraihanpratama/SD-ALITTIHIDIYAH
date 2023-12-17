<?php

namespace App\Modules\Admin\Guru\Actions;

class GuruDeleteAction
{
    public function delete($request, $id)
    {
        dd($request->all(), $id);
    }
}