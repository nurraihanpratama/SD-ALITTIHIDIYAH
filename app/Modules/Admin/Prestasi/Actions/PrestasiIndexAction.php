<?php

namespace App\Modules\Admin\Prestasi\Actions;

use Inertia\Inertia;

class PrestasiIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Data Prestasi"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Prestasi/Index', $props);
    }
}