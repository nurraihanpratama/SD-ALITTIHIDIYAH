<?php

namespace App\Modules\Admin\Pegawai\Actions;

use Inertia\Inertia;

class PegawaiIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Data Pegawai"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Pegawai/Index', $props);
    }
}