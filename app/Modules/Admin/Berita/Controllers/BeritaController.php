<?php

namespace App\Modules\Admin\Berita\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Berita\Actions\BeritaCreateAction;
use App\Modules\Admin\Berita\Actions\BeritaDeleteAction;
use App\Modules\Admin\Berita\Actions\BeritaIndexAction;
use App\Modules\Admin\Berita\Actions\BeritaStoreAction;
use App\Modules\Admin\Berita\Actions\BeritaUpdateAction;
use Illuminate\Http\Request;

class BeritaController extends Controller
{
    public function index(Request $request)
    {
        return (New BeritaIndexAction)->index($request);
    }

    // Show Options
    public function create()
    {
        return (New BeritaCreateAction)->options();
    }

    // Store Data
    public function store(Request $request)
    {
        return (New BeritaStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New BeritaUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New BeritaDeleteAction)->delete($request,  $id);
    }
}
