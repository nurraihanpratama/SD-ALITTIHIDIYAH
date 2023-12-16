<?php

namespace App\Modules\Admin\Pegawai\Actions;

use App\Modules\Admin\Pegawai\Tables\PegawaiDataTable;
use Inertia\Inertia;

class PegawaiIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Pegawai"
        ];

        $collection = (new PegawaiDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Pegawai/Index', $props);
    }
}
