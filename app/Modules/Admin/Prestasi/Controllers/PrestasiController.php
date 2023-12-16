<?php

namespace App\Modules\Admin\Prestasi\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Prestasi\Actions\PrestasiIndexAction;
use Illuminate\Http\Request;

class PrestasiController extends Controller
{
    public function index(Request $request)
    {
        return (New PrestasiIndexAction)->index($request);
    }
}
