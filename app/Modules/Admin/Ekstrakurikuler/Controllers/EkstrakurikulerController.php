<?php

namespace App\Modules\Admin\Ekstrakurikuler\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Ekstrakurikuler\Actions\EkstrakurikulerIndexAction;
use Illuminate\Http\Request;

class EkstrakurikulerController extends Controller
{
    public function index(Request $request)
    {
        return (New EkstrakurikulerIndexAction)->index($request);
    }
}
