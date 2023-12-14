<?php

namespace App\Modules\Admin\BidangStudi\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\BidangStudi\Actions\BidangStudiIndexAction;

class BidangStudiController extends Controller
{
    public function index()
    {
        return (New BidangStudiIndexAction)->index();
        
    }
}