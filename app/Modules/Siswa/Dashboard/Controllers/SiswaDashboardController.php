<?php

namespace App\Modules\Siswa\Dashboard\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siswa\Dashboard\Actions\SiswaDashboardIndexAction;
use Illuminate\Http\Request;

class SiswaDashboardController extends Controller
{
    public function index(Request $request)
    {
        return (new SiswaDashboardIndexAction)->index($request);
    }
}
