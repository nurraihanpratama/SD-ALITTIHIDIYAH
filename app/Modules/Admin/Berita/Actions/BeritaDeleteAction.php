<?php

namespace App\Modules\Admin\Berita\Actions;

class BeritaDeleteAction
{
    public function delete($request, $id)
    {
        dd($request->all(), $id);
    }
}