<?php

namespace App\Modules\Admin\Fasilitas\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Fasilitas\Actions\FasilitasIndexAction;
use Illuminate\Http\Request;

class FasilitasController extends Controller
{
    public function index(Request $request)
    {
        return (New FasilitasIndexAction)->index($request);
    }
}
