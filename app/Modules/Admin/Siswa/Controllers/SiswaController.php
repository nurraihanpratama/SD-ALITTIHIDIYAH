<?php

namespace App\Modules\Admin\Siswa\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Siswa\Actions\SiswaCreateAction;
use App\Modules\Admin\Siswa\Actions\SiswaIndexAction;
use App\Modules\Admin\Siswa\Actions\SiswaStoreAction;
use Illuminate\Http\Request;

class SiswaController extends Controller
{
    public function index(Request $request)
    {
        return (New SiswaIndexAction)->index($request);
        
    }

    public function create()
    {
        return (New SiswaCreateAction)->options();
    }

    public function store(Request $request)
    {
        return (New SiswaStoreAction)->store($request);
    }
}