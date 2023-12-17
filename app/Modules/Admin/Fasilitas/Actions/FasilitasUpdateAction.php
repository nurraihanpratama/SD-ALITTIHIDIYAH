<?php

namespace App\Modules\Admin\Fasilitas\Actions;

class FasilitasUpdateAction
{
    public function update($request, $id)
    {
        dd($request->all(), $id);
    }
}