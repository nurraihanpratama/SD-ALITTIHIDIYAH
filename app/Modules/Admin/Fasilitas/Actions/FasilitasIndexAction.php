<?php

namespace App\Modules\Admin\Fasilitas\Actions;

use App\Modules\Admin\Fasilitas\Tables\FasilitasDataTable;
use Inertia\Inertia;

class FasilitasIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Fasilitas"
        ];

        $collection = (new FasilitasDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Fasilitas/Index', $props);
    }
}
