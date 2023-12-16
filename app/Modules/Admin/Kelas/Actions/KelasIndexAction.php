<?php

namespace App\Modules\Admin\Kelas\Actions;

use App\Modules\Admin\Kelas\Tables\KelasDataTable;
use Inertia\Inertia;

class KelasIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Kelas"
        ];

        $collection = (new KelasDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Kelas/Index', $props);
    }
}
