<?php

namespace App\Modules\Admin\Siswa\Actions;

use App\Modules\Admin\Siswa\Tables\SiswaDataTable;
use Inertia\Inertia;

class SiswaIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Siswa"
        ];

        $collection = (new SiswaDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Siswa/Index', $props);
    }
}