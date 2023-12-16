<?php

namespace App\Modules\Admin\Pegawai\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Pegawai\Actions\PegawaiIndexAction;
use Illuminate\Http\Request;

class PegawaiController extends Controller
{
    public function index(Request $request)
    {
        return (New PegawaiIndexAction)->index($request);
    }
}
