<?php

namespace App\Modules\Admin\Fasilitas\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Fasilitas\Actions\FasilitasIndexAction;

class FasilitasController extends Controller
{
    public function index()
    {
        return (New FasilitasIndexAction)->index();
        
    }
}