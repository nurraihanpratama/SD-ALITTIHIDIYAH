<?php

namespace App\Modules\Admin\Dashboard\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Dashboard\Actions\DashboardIndexAction;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        return (new DashboardIndexAction)->index($request);
    }
}
