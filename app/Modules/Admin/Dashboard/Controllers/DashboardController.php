<?php

namespace App\Modules\Admin\Dashboard\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\Dashboard\Actions\DashboardIndexAction;

class DashboardController extends Controller
{
    public function index(){
        return (New DashboardIndexAction)->index();
    }
}