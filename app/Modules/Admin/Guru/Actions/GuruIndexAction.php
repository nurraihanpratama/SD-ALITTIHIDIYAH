<?php

namespace App\Modules\Admin\Guru\Actions;

use Inertia\Inertia;

class GuruIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Data Guru"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Guru/Index', $props);
    }
}