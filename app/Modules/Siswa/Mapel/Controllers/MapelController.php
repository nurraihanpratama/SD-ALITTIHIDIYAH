<?php

namespace App\Modules\Siswa\Mapel\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siswa\Mapel\Actions\MapelIndexAction;

class MapelController extends Controller
{
    public function index()
    {
        return (New MapelIndexAction)->index();
    }
}