<?php

namespace App\Modules\Admin\Kelas\Actions;

class KelasStoreAction
{
    public function store($request)
    {
        try {
            dd($request);
        } catch (\Throwable $th) {
            //throw $th;
        }
    }
}