<?php

namespace App\Modules\Admin\BidangStudi\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\BidangStudi\Actions\BidangStudiIndexAction;
use Illuminate\Http\Request;

class BidangStudiController extends Controller
{
    public function index(Request $request)
    {
        return (New BidangStudiIndexAction)->index($request);
    }
}
