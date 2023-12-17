<?php

namespace App\Modules\Admin\Fasilitas\Actions;

class FasilitasDeleteAction
{
    public function delete($request, $id)
    {
        dd($request->all(), $id);
    }
}