<?php
namespace App\Modules\Admin\DataSiswa\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Admin\DataSiswa\Actions\DataSiswaIndexAction;
use Illuminate\Http\Request;

class DataSiswaController extends Controller
{
    public function index(Request $request)
    {
        return (New DataSiswaIndexAction)->index($request);
    }
}
