<?php

namespace App\Modules\Admin\Siswa\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Siswa\Actions\SiswaCreateAction;
use App\Modules\Admin\Siswa\Actions\SiswaDeleteAction;
use App\Modules\Admin\Siswa\Actions\SiswaIndexAction;
use App\Modules\Admin\Siswa\Actions\SiswaStoreAction;
use App\Modules\Admin\Siswa\Actions\SiswaUpdateAction;
use Illuminate\Http\Request;

class SiswaController extends Controller
{
    public function index(Request $request)
    {
        return (New SiswaIndexAction)->index($request);

    }

    public function create()
    {
        return (New SiswaCreateAction)->options();
    }

    public function store(Request $request)
    {
        return (New SiswaStoreAction)->store($request);
    }

     // Update Data from id
     public function update(Request $request, string $id)
     {
        return (New SiswaUpdateAction)->update($request, $id);
     }

     public function delete(string $id)
    {
        return (New SiswaDeleteAction)->delete($id);
    }
}
