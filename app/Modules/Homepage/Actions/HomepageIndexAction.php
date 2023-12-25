<?php

namespace App\Modules\Homepage\Actions;

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

class HomepageIndexAction
{
    public function index()
    {
        return Inertia::render('Homepage/Index', [
        'canLogin' => Route::has('login'),

        ]);
    }
}