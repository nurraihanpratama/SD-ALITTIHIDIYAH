<?php

namespace App\Modules\Admin\BidangStudi\Actions;

use Inertia\Inertia;

class BidangStudiIndexAction
{
    public function index()
    {
        $page = [
            "title" => "Data Bidang Studi"
        ];

        $props = compact('page');

        return Inertia::render('Admin/BidangStudi/Index', $props);
    }
}