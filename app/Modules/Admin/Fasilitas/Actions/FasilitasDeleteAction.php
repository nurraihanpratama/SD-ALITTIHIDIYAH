<?php

namespace App\Modules\Admin\Ekstrakurikuler\Actions;

class EkstrakurikulerDeleteAction
{
    public function delete($request, $id)
    {
        dd($request->all(), $id);
    }
}