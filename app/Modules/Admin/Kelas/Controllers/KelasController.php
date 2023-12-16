<?php

namespace App\Modules\Admin\Kelas\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Kelas\Actions\KelasIndexAction;
use Illuminate\Http\Request;

class KelasController extends Controller
{
    public function index(Request $request)
    {
        return (New KelasIndexAction)->index($request);
    }
}
