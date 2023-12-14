<?php

namespace App\Modules\Admin\Ekstrakurikuler\Actions;

use Inertia\Inertia;

class EkstrakurikulerIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Data Ekstrakurikuler"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Ekstrakurikuler/Index', $props);
    }
}