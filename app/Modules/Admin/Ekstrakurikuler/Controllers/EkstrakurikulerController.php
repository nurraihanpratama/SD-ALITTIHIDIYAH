<?php

namespace App\Modules\Admin\Ekstrakurikuler\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Ekstrakurikuler\Actions\EkstrakurikulerDeleteAction;
use App\Modules\Admin\Ekstrakurikuler\Actions\EkstrakurikulerIndexAction;
use App\Modules\Admin\Ekstrakurikuler\Actions\EkstrakurikulerStoreAction;
use App\Modules\Admin\Ekstrakurikuler\Actions\EkstrakurikulerUpdateAction;
use Illuminate\Http\Request;

class EkstrakurikulerController extends Controller
{
    public function index(Request $request)
    {
        return (New EkstrakurikulerIndexAction)->index($request);
    }

    // Store Data
    public function store(Request $request)
    {
        return (New EkstrakurikulerStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New EkstrakurikulerUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New EkstrakurikulerDeleteAction)->delete($request,  $id);
    }
}
