<?php

namespace App\Modules\Admin\Dashboard\Actions;

use Inertia\Inertia;

class DashboardIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Dashboard"
        ];

        $props = compact('page');

        return Inertia::render('Admin/Dashboard/Index', $props);
    }
}