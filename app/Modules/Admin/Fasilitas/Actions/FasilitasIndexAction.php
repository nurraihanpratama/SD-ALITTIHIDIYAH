<?php

namespace App\Modules\Admin\Fasilitas\Actions;

use Inertia\Inertia;

class FasilitasIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Data Fasilitas"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Fasilitas/Index', $props);
    }
}