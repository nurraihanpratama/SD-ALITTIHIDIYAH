<?php

namespace App\Modules\Admin\Kelas\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Kelas\Actions\KelasCreateAction;
use App\Modules\Admin\Kelas\Actions\KelasDeleteAction;
use App\Modules\Admin\Kelas\Actions\KelasIndexAction;
use App\Modules\Admin\Kelas\Actions\KelasStoreAction;
use App\Modules\Admin\Kelas\Actions\KelasUpdateAction;
use Illuminate\Http\Request;

class KelasController extends Controller
{
    public function index(Request $request)
    {
        return (New KelasIndexAction)->index($request);
    }

    // Show Option Data
    public function create()
    {
        return (New KelasCreateAction)->options();
    }

    // Store To DB
    public function store(Request $request)
    {
        return (New KelasStoreAction)->store($request);
    }

    // Update Data from id
    public function update(Request $request, string $id)
    {
        return (New KelasUpdateAction)->update($request, $id);
    }

    // Delete Data 
    public function delete(Request $request, string $id)
    {
        return (New KelasDeleteAction)->delete($request, $id);
    }
}
