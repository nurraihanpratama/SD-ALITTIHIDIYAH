<?php

namespace App\Modules\Admin\Prestasi\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Prestasi\Actions\PrestasiIndexAction;

class PrestasiController extends Controller
{
    public function index()
    {
        return (New PrestasiIndexAction)->index();
        
    }
}