<?php

namespace App\Modules\Admin\Kelas\Actions;

class KelasUpdateAction
{
    public function update($request, $id)
    {
        try {
            dd($request);
        } catch (\Throwable $th) {
            //throw $th;
        }
    }
}