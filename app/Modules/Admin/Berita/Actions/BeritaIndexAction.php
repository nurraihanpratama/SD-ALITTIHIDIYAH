<?php

namespace App\Modules\Admin\Berita\Actions;

use App\Modules\Admin\Berita\Tables\BeritaDataTable;
use Inertia\Inertia;

class BeritaIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data Berita"
        ];

        $collection = (new BeritaDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/Berita/Index', $props);
    }
}
