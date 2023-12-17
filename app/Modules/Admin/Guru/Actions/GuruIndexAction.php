<?php

namespace App\Modules\Admin\Guru\Actions;

use App\Modules\Admin\Guru\Tables\GuruDataTable;
use Inertia\Inertia;

class GuruIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Guru"
        ];

        $collection = (new GuruDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Guru/Index', $props);
    }
}
