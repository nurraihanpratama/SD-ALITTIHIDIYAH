<?php

namespace App\Modules\Admin\Guru\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Guru\Actions\GuruIndexAction;

class GuruController extends Controller
{
    public function index()
    {
        return (New GuruIndexAction)->index();
        
    }
}