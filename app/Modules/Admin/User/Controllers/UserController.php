<?php

namespace App\Modules\Admin\User\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\User\Actions\UserIndexAction;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(Request $request)
    {
        return (New UserIndexAction)->index($request);
    }
}