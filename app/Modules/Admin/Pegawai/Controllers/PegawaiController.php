<?php

namespace App\Modules\Admin\Pegawai\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Pegawai\Actions\PegawaiIndexAction;

class PegawaiController extends Controller
{
    public function index()
    {
        return (New PegawaiIndexAction)->index();
        
    }
}