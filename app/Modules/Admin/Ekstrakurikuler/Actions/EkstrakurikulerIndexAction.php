<?php

namespace App\Modules\Admin\Ekstrakurikuler\Actions;

use App\Modules\Admin\Ekstrakurikuler\Tables\EkstrakurikulerDataTable;
use Inertia\Inertia;

class EkstrakurikulerIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Ekstrakurikuler"
        ];

        $collection = (new EkstrakurikulerDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Ekstrakurikuler/Index', $props);
    }
}
