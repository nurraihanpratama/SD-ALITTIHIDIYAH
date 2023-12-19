<?php

namespace App\Modules\Siswa\DataNilai\Actions;

use App\Modules\Siswa\DataNilai\Tables\DataNilaiDataTable;
use Inertia\Inertia;

class DataNilaiIndexAction
{
    public function index($request)
    {
        $page = [
            'title' => "Data Nilai Siswa",
        ];

        $collection = (new DataNilaiDataTable)->generate($request);

        $props = compact('page', 'collection');

        return Inertia::render('Siswa/DataNilai/Index', $props);
    }
}