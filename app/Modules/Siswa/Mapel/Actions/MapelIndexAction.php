<?php

namespace App\Modules\Siswa\Mapel\Actions;

use Inertia\Inertia;

class MapelIndexAction
{
    public function index()
    {
        $page = [
            'title' => "Data Pelajaran Siswa",
        ];

        $collection = [];

        $props = compact('page', 'collection');

        return Inertia::render('Siswa/Mapel/Index', $props);
    }
}