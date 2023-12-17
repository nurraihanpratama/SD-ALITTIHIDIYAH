<?php

namespace App\Modules\Admin\JadwalPelajaran\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\JadwalPelajaran\Actions\JadwalPelajaranDeleteAction;
use App\Modules\Admin\JadwalPelajaran\Actions\JadwalPelajaranIndexAction;
use App\Modules\Admin\JadwalPelajaran\Actions\JadwalPelajaranStoreAction;
use App\Modules\Admin\JadwalPelajaran\Actions\JadwalPelajaranUpdateAction;
use Illuminate\Http\Request;

class JadwalPelajaranController extends Controller
{
    public function index(Request $request)
    {
        return (New JadwalPelajaranIndexAction)->index($request);
    }

    // Store Data
    public function store(Request $request)
    {
        return (New JadwalPelajaranStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New JadwalPelajaranUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New JadwalPelajaranDeleteAction)->delete($request,  $id);
    }

}
