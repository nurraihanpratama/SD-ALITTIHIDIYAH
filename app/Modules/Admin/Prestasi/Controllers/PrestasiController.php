<?php

namespace App\Modules\Admin\Prestasi\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Prestasi\Actions\PrestasiDeleteAction;
use App\Modules\Admin\Prestasi\Actions\PrestasiIndexAction;
use App\Modules\Admin\Prestasi\Actions\PrestasiStoreAction;
use App\Modules\Admin\Prestasi\Actions\PrestasiUpdateAction;
use Illuminate\Http\Request;

class PrestasiController extends Controller
{
    public function index(Request $request)
    {
        return (New PrestasiIndexAction)->index($request);
    }

    // Store Data
    public function store(Request $request)
    {
        return (New PrestasiStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New PrestasiUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New PrestasiDeleteAction)->delete($request,  $id);
    }
}
