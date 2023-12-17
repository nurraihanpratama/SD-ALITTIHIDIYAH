<?php

namespace App\Modules\Admin\Fasilitas\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Fasilitas\Actions\FasilitasDeleteAction;
use App\Modules\Admin\Fasilitas\Actions\FasilitasIndexAction;
use App\Modules\Admin\Fasilitas\Actions\FasilitasStoreAction;
use App\Modules\Admin\Fasilitas\Actions\FasilitasUpdateAction;
use Illuminate\Http\Request;

class FasilitasController extends Controller
{
    public function index(Request $request)
    {
        return (New FasilitasIndexAction)->index($request);
    }

    // Store Data
    public function store(Request $request)
    {
        return (New FasilitasStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New FasilitasUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New FasilitasDeleteAction)->delete($request,  $id);
    }
}
