<?php

namespace App\Modules\Admin\Berita\Actions;

use Inertia\Inertia;

class BeritaIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Data Berita"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Berita/Index', $props);
    }
}