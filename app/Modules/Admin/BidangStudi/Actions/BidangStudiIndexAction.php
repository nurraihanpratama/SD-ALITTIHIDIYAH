<?php

namespace App\Modules\Admin\BidangStudi\Actions;

use App\Modules\Admin\BidangStudi\Tables\BidangStudiDataTable;
use Inertia\Inertia;

class BidangStudiIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Data BidangStudi"
        ];

        $collection = (new BidangStudiDataTable)->generate($request);
        $props = compact('page', 'collection');

        return Inertia::render('Admin/BidangStudi/Index', $props);
    }
}
