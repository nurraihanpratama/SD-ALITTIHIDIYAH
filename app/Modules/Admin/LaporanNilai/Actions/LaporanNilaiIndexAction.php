<?php

namespace App\Modules\Admin\LaporanNilai\Actions;

use App\Modules\Admin\LaporanNilai\Tables\LaporanNilaiDataTable;
use Inertia\Inertia;

class LaporanNilaiIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Laporan Nilai Siswa"
        ];

        $collection = (new LaporanNilaiDataTable)->generate($request);

        $props = compact('page','collection');

        return Inertia::render('Guru/LaporanNilai/Index', $props);


    }
}