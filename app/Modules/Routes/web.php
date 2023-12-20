<?php

use App\Modules\Admin\Berita\Controllers\BeritaController;
use App\Modules\Admin\BidangStudi\Controllers\BidangStudiController;
use App\Modules\Admin\Dashboard\Controllers\DashboardController;
use App\Modules\Admin\Ekstrakurikuler\Controllers\EkstrakurikulerController;
use App\Modules\Admin\Fasilitas\Controllers\FasilitasController;
use App\Modules\Admin\Guru\Controllers\GuruController;
use App\Modules\Admin\JadwalPelajaran\Controllers\JadwalPelajaranController;
use App\Modules\Admin\Kelas\Controllers\KelasController;
use App\Modules\Admin\Pegawai\Controllers\PegawaiController;
use App\Modules\Admin\Prestasi\Controllers\PrestasiController;
use App\Modules\Admin\Siswa\Controllers\SiswaController;
use Illuminate\Support\Facades\Route;


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
Route::middleware(['auth', 'verified','ShareFlashes'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function() {

        Route::controller(DashboardController::class)
            ->middleware(['auth', 'verified'])
            ->name('dashboard.')
            ->prefix('/dashboard')
            ->group(function() {
                Route::get('/', 'index')->name('index');
        });


        Route::controller(KelasController::class)
            ->middleware(['auth', 'verified'])
            ->name('kelas.')
            ->prefix('/kelas')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{kelas}', 'update')->name('update');
                Route::delete('/delete/{kelas}', 'delete')->name('delete');
        });

        Route::controller(SiswaController::class)
            ->middleware(['auth', 'verified'])
            ->name('siswa.')
            ->prefix('/siswa')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{siswa}', 'update')->name('update');
        });

        Route::controller(GuruController::class)
            ->middleware(['auth', 'verified'])
            ->name('guru.')
            ->prefix('/guru')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{guru}', 'update')->name('update');
        });

        Route::controller(BidangStudiController::class)
            ->middleware(['auth', 'verified'])
            ->name('bidang-studi.')
            ->prefix('/bidang-studi')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{bidang-studi}', 'update')->name('update');
        });

        Route::controller(JadwalPelajaranController::class)
            ->middleware(['auth', 'verified'])
            ->name('jadwal-pelajaran.')
            ->prefix('/jadwal-pelajaran')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{jadwal-pelajaran}', 'update')->name('update');
        });

        Route::controller(PegawaiController::class)
            ->middleware(['auth', 'verified'])
            ->name('pegawai.')
            ->prefix('/pegawai')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{pegawai}', 'update')->name('update');
        });

        Route::controller(PrestasiController::class)
            ->middleware(['auth', 'verified'])
            ->name('prestasi.')
            ->prefix('/prestasi')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{prestasi}', 'update')->name('update');
        });

        Route::controller(EkstrakurikulerController::class)
            ->middleware(['auth', 'verified'])
            ->name('ekstrakurikuler.')
            ->prefix('/ekstrakurikuler')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{ekstrakurikuler}', 'update')->name('update');
        });

        Route::controller(FasilitasController::class)
            ->middleware(['auth', 'verified'])
            ->name('fasilitas.')
            ->prefix('/fasilitas')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{fasilitas}', 'update')->name('update');
        });

        Route::controller(BeritaController::class)
            ->middleware(['auth', 'verified'])
            ->name('berita.')
            ->prefix('/berita')
            ->group(function() {
                Route::get('/', 'index')->name('index');
                Route::get('/create', 'create')->name('create');
                Route::post('/store', 'store')->name('store');
                Route::patch('/update/{berita}', 'update')->name('update');
        });

        
    });