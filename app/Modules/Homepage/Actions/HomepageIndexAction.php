<?php

namespace App\Modules\Homepage\Actions;

use Inertia\Inertia;

class HomepageIndexAction
{
    public function index()
    {
        return Inertia::render('Homepage/Index');
    }
}