<?php

namespace App\Modules\Admin\Kelas\Actions;

use Inertia\Inertia;

class KelasIndexAction
{
    public function index()
    {
        
        $page = [
            "title" => "Data Kelas"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Kelas/Index', $props);
    }
}