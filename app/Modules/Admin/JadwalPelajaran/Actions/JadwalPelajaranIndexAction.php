<?php

namespace App\Modules\Admin\JadwalPelajaran\Actions;

use Inertia\Inertia;

class JadwalPelajaranIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Jadwal Pelajaran"
        ];

        $props = compact('page');

        return Inertia::render('Admin/JadwalPelajaran/Index', $props);
    }
}