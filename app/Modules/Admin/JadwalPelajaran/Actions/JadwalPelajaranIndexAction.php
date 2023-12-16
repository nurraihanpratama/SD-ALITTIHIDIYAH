<?php

namespace App\Modules\Admin\JadwalPelajaran\Actions;

use App\Modules\Admin\JadwalPelajaran\Tables\JadwalPelajaranDataTable;
use Inertia\Inertia;

class JadwalPelajaranIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Jadwal Pelajaran"
        ];

        $collection = (new JadwalPelajaranDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/JadwalPelajaran/Index', $props);
    }
}
