<?php

namespace App\Modules\Admin\Berita\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Berita\Actions\BeritaIndexAction;
use Illuminate\Http\Request;

class BeritaController extends Controller
{
    public function index(Request $request)
    {
        return (New BeritaIndexAction)->index($request);
    }
}
