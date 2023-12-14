<?php

namespace App\Modules\Admin\Berita\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Berita\Actions\BeritaIndexAction;

class BeritaController extends Controller
{
    public function index()
    {
        return (New BeritaIndexAction)->index();
    }
}