<?php

namespace App\Modules\Admin\JadwalPelajaran\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\JadwalPelajaran\Actions\JadwalPelajaranIndexAction;

class JadwalPelajaranController extends Controller
{
    public function index()
    {
        return (New JadwalPelajaranIndexAction)->index(); 
    }
}