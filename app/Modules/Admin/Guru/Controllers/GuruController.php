<?php

namespace App\Modules\Admin\Guru\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Guru\Actions\GuruIndexAction;
use Illuminate\Http\Request;

class GuruController extends Controller
{
    public function index(Request $request)
    {
        return (New GuruIndexAction)->index($request);
    }
}
