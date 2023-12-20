<?php

namespace App\Modules\Admin\DataSiswa\Actions;

use App\Models\TblAkun;
use App\Modules\Admin\DataSiswa\Tables\DataSiswaDataTable;
use Inertia\Inertia;

class DataSiswaIndexAction
{
    public function index($request)
    {
        $page = [
            'title' => 'Data Siswa'
        ];

        $collection = (new DataSiswaDataTable)->generate($request);
        $props = compact('page', 'collection');
        return Inertia::render('Guru/DataSiswa/Index', $props);
    }
}