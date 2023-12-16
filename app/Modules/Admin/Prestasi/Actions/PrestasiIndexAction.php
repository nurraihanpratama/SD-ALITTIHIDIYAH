<?php

namespace App\Modules\Admin\Prestasi\Actions;

use App\Modules\Admin\Prestasi\Tables\PrestasiDataTable;
use Inertia\Inertia;

class PrestasiIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Prestasi"
        ];

        $collection = (new PrestasiDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Prestasi/Index', $props);
    }
}
