<?php

use App\Http\Controllers\ProfileController;
use App\Models\TblAkun;
use App\Models\TblSiswa;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Modules\Admin\JadwalPelajaran\Actions\JadwalPelajaranIndexAction;
use App\Modules\Homepage\Controllers\HomepageController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::get('/', function () {
//     return Inertia::render('Welcome', [
//         'canLogin' => Route::has('login'),
//         'canRegister' => Route::has('register'),
//         'laravelVersion' => Application::VERSION,
//         'phpVersion' => PHP_VERSION,
//     ]);
// });

Route::get('/', [HomepageController::class, 'index'])->name('homepage.index');

// Homepage
Route::get('/home', [ProfileController::class,'index']);
Route::get('/b1', [ProfileController::class,'news']);
Route::get('/b2', [ProfileController::class,'news2']);
Route::get('/b3', [ProfileController::class,'news3']);
Route::get('/facilitate', [ProfileController::class,'facilitate']);
Route::get('/directory', [ProfileController::class,'directory']);

// Route::get('/dashboard', function () {
//     return Inertia::render('Dashboard');
// })->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Menambahkan rute untuk JadwalPelajaranIndexAction
Route::middleware('auth')->group(function () {
    Route::get('/admin/jadwal-pelajaran', [JadwalPelajaranIndexAction::class, 'index'])->name('admin.jadwal-pelajaran.index');
});

require __DIR__.'/auth.php';
