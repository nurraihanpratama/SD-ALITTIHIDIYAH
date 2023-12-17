<?php

namespace App\Modules\Admin\Pegawai\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Pegawai\Actions\PegawaiDeleteAction;
use App\Modules\Admin\Pegawai\Actions\PegawaiIndexAction;
use App\Modules\Admin\Pegawai\Actions\PegawaiStoreAction;
use App\Modules\Admin\Pegawai\Actions\PegawaiUpdateAction;
use Illuminate\Http\Request;

class PegawaiController extends Controller
{
    public function index(Request $request)
    {
        return (New PegawaiIndexAction)->index($request);
    }

    // Store Data
    public function store(Request $request)
    {
        return (New PegawaiStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New PegawaiUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New PegawaiDeleteAction)->delete($request,  $id);
    }
}
