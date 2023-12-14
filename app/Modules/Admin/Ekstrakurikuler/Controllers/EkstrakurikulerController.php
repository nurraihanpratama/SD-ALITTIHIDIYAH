<?php

namespace App\Modules\Admin\Ekstrakurikuler\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Ekstrakurikuler\Actions\EkstrakurikulerIndexAction;

class EkstrakurikulerController extends Controller
{
    public function index()
    {
        return (New EkstrakurikulerIndexAction)->index();
        
    }
}