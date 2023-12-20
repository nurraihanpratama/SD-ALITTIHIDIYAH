<?php

namespace App\Modules\Siswa\DataNilai\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siswa\DataNilai\Actions\DataNilaiIndexAction;
use Illuminate\Http\Request;

class DataNilaiController extends Controller
{
    public function index(Request $request)
    {
        return (New DataNilaiIndexAction)->index($request);
    }
}