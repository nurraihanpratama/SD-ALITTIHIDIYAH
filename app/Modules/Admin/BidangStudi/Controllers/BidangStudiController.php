<?php

namespace App\Modules\Admin\BidangStudi\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\BidangStudi\Actions\BidangStudiDeleteAction;
use App\Modules\Admin\BidangStudi\Actions\BidangStudiIndexAction;
use App\Modules\Admin\BidangStudi\Actions\BidangStudiStoreAction;
use App\Modules\Admin\BidangStudi\Actions\BidangStudiUpdateAction;
use Illuminate\Http\Request;

class BidangStudiController extends Controller
{
    public function index(Request $request)
    {
        return (New BidangStudiIndexAction)->index($request);
    }
    
        // Store Data
    public function store(Request $request)
    {
        return (New BidangStudiStoreAction)->store($request);
    }

    // Edit Data
    public function update(Request $request, String $id)
    {
        return (New BidangStudiUpdateAction)->update($request,  $id);
    }

    // Delete Data
    public function delete(Request $request, String $id)
    {
        return (New BidangStudiDeleteAction)->delete($request,  $id);
    }
}
