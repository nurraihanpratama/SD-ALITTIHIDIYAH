<?php

namespace App\Modules\Homepage\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Homepage\Actions\HomepageIndexAction;

class HomepageController extends Controller
{
    public function index()
    {
        return (New HomepageIndexAction)->index();
    }
}