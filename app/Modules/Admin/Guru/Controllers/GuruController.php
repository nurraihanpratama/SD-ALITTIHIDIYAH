<?php

namespace App\Modules\Admin\Guru\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Guru\Actions\GuruCreateAction;
use App\Modules\Admin\Guru\Actions\GuruDeleteAction;
use App\Modules\Admin\Guru\Actions\GuruIndexAction;
use App\Modules\Admin\Guru\Actions\GuruStoreAction;
use App\Modules\Admin\Guru\Actions\GuruUpdateAction;
use Illuminate\Http\Request;

class GuruController extends Controller
{
    public function index(Request $request)
    {
        return (New GuruIndexAction)->index($request);
    }

    // Show Options
    public function create()
    {
        return (New GuruCreateAction)->options();
    }

    // Store Data
    public function store(Request $request)
    {
        return (New GuruStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New GuruUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New GuruDeleteAction)->delete($request,  $id);
    }
}
