<?php

namespace App\Modules\Guru\Dashboard\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Guru\Dashboard\Actions\GuruDashboardIndexAction;
use Illuminate\Http\Request;

class GuruDashboardController extends Controller
{
    public function index(Request $request)
    {
        return (new GuruDashboardIndexAction)->index($request);
    }
}
