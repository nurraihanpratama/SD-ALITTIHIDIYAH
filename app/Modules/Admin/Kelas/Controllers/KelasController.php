<?php

namespace App\Modules\Admin\Kelas\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Kelas\Actions\KelasIndexAction;

class KelasController extends Controller
{
    public function index()
    {
        return (New KelasIndexAction)->index();
    }
}