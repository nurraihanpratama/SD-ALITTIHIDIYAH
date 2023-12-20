<?php

use App\Modules\Admin\Berita\Controllers\BeritaController;
use App\Modules\Admin\BidangStudi\Controllers\BidangStudiController;
use App\Modules\Admin\Dashboard\Controllers\DashboardController;
use App\Modules\Admin\DataSiswa\Controllers\DataSiswaController;
use App\Modules\Admin\Ekstrakurikuler\Controllers\EkstrakurikulerController;
use App\Modules\Admin\Fasilitas\Controllers\FasilitasController;
use App\Modules\Admin\Guru\Controllers\GuruController;
use App\Modules\Admin\JadwalPelajaran\Controllers\JadwalPelajaranController;
use App\Modules\Admin\Kelas\Controllers\KelasController;
use App\Modules\Admin\LaporanNilai\Controllers\LaporanNilaiController;
use App\Modules\Admin\LaporanNilai\Tables\DataSiswaDataTable;
use App\Modules\Admin\Pegawai\Controllers\PegawaiController;
use App\Modules\Admin\Prestasi\Controllers\PrestasiController;
use App\Modules\Admin\Siswa\Controllers\SiswaController;
use App\Modules\MyProfile\Controllers\MyProfileController;
use App\Modules\Siswa\Dashboard\Controllers\SiswaDashboardController;
use App\Modules\Siswa\DataNilai\Controllers\DataNilaiController;
use App\Modules\Siswa\Mapel\Controllers\MapelController;
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
Route::prefix('/')
	->middleware(['auth', 'verified'])
	->group(function () {
		Route::post('/my-profile/{user_id}', [MyProfileController::class, 'update'])
			->name('my-profile.update');

		Route::patch('/my-profile/update-password/{user_id}', [MyProfileController::class, 'updatePassword'])
			->name('my-profile.update-password');

		Route::resource('my-profile', MyProfileController::class)
			->only(['index']);
	});


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
                Route::delete('/delete/{siswa}', 'delete')->name('delete');

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
                Route::delete('/delete/{guru}', 'delete')->name('delete');

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
                Route::delete('/delete/{bidang-studi}', 'delete')->name('delete');

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
                Route::delete('/delete/{jadwal-pelajaran}', 'delete')->name('delete');

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
                Route::delete('/delete/{pegawai}', 'delete')->name('delete');
                
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
                Route::delete('/delete/{prestasi}', 'delete')->name('delete');

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
                Route::delete('/delete/{ekstrakurikuler}', 'delete')->name('delete');

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
                Route::delete('/delete/{fasilitas}', 'delete')->name('delete');

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
                Route::delete('/delete/{berita}', 'delete')->name('delete');

        });
        
    });

    
    // * UNTUK ROUTES GURU PANEL
    Route::middleware(['auth', 'verified','ShareFlashes'])
    ->prefix('guru')
    ->name('guru.')
    ->group(function() {

        // * Data Siswa
        Route::controller(DataSiswaController::class)
            ->name('data-siswa.')
            ->prefix('/data-siswa')
            ->group(function () {
                Route::get('/', 'index')->name('index');
            });

        // * Laporan Nilai
        Route::controller(LaporanNilaiController::class)
            ->name('laporan-nilai.')
            ->prefix('/laporan-nilai')
            ->group(function() {
                Route::get('/', 'index')->name('index');
            });
        Route::get('laporan-nilai/datatabel', [DataSiswaDataTable::class, 'generate'])->name('laporan-nilai.datatable');
    });
    

        // * UNTUK ROUTES SISWA PANEL
        Route::middleware(['auth', 'verified','ShareFlashes'])
        ->prefix('siswa')
        ->name('siswa.')
        ->group(function() {
            
            Route::controller(SiswaDashboardController::class)
                ->name('dashboard.')
                ->prefix('/dashboard')
                ->group(function() {
                    Route::get('/', 'index')->name('index');
                });

            // * Data Mapel
            Route::controller(MapelController::class)
                ->name('mapel.')
                ->prefix('/mapel')
                ->group(function () {
                    Route::get('/', 'index')->name('index');
                });

            Route::controller(DataNilaiController::class)
                ->name('data-nilai.')
                ->prefix('/data-nilai')
                ->group(function () {
                    Route::get('/', 'index')->name('index');
                });
        });
        