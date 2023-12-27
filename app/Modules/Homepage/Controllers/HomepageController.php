<?php

namespace App\Modules\Homepage\Controllers;

use App\Http\Controllers\Controller;
use App\Models\TblSiswa;
use App\Modules\Homepage\Actions\HomepageIndexAction;

class HomepageController extends Controller
{
    public function index()
    {
        return (New HomepageIndexAction)->index();
    }

    public function show()
    {
        return view('bismillah_msbd/index');
    }
    public function news() {
        return view('bismillah_msbd.components.berita1');
    }
    public function news2() {
        return view('bismillah_msbd.components.berita2');
    }
    public function news3() {
        return view('bismillah_msbd.components.berita3');
    }
    public function facilitate() {
        return view('bismillah_msbd.fasilitas');
    }
    public function directory() {
        $students = TblSiswa::all(); // Get all students from database
        return view('bismillah_msbd.direk', compact('students')); // Pass students to the view
    }
}