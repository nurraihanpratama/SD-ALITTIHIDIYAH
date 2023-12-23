<?php

namespace App\Modules\Admin\LaporanNilai\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\LaporanNilai\Actions\LaporanNilaiCreateAction;
use App\Modules\Admin\LaporanNilai\Actions\LaporanNilaiIndexAction;
use Illuminate\Http\Request;

class LaporanNilaiController extends Controller
{
    public function index(Request $request)
    {
        return (New LaporanNilaiIndexAction)->index($request);
    }

    public function create()
    {
        return (New LaporanNilaiCreateAction)->options();
    }
}