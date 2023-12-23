<?php

namespace App\Modules\Siswa\Dashboard\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siswa\Dashboard\Actions\SiswaDashboardIndexAction;

class SiswaDashboardController extends Controller
{
    public function index()
    {
        return (new SiswaDashboardIndexAction)->index();
    }
}
