<?php

namespace App\Modules\Admin\Prestasi\Actions;

class PrestasiDeleteAction
{
    public function delete($request, $id)
    {
        dd($request->all(), $id);
    }
}