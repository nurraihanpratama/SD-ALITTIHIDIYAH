<?php

namespace App\Modules\Admin\Siswa\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Siswa\Actions\SiswaIndexAction;
use Illuminate\Http\Request;

class SiswaController extends Controller
{
    public function index(Request $request)
    {
        return (New SiswaIndexAction)->index($request);
        
    }
}