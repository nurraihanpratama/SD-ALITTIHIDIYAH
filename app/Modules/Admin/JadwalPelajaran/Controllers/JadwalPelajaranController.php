<?php

namespace App\Modules\Admin\JadwalPelajaran\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\JadwalPelajaran\Actions\JadwalPelajaranIndexAction;
use Illuminate\Http\Request;

class JadwalPelajaranController extends Controller
{
    public function index(Request $request)
    {
        return (New JadwalPelajaranIndexAction)->index($request);
    }
}
