<?php

namespace App\Modules\Guru\Dashboard\Actions;

use Inertia\Inertia;
use App\Models\TblKelas;
use App\Models\TblGuru;
use App\Models\TblSiswa;
use App\Models\TblBidangStudi;
use App\Models\TblRoster;
use App\Models\TblPegawai;
use App\Models\TblPrestasi;
use App\Models\TblEkstrakurikuler;
use App\Models\TblFasilitas;
use App\Models\TblBerita;
use App\Models\TblMapelGuru;
use Illuminate\Support\Facades\Auth;

class GuruDashboardIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Dashboard"
        ];

        $guru = TblGuru::where('user_id', Auth::user()->uuid)->first();
        $id_kelas = TblKelas::get('id_kelas');
        $data_kelas = count(TblRoster::with(['guru'])->get());
        // dd($data_kelas);
        $dashboardData = [
            
            'Data Guru' => TblGuru::count(),
            'Data Siswa' => TblSiswa::count(),
            'Data Bidang Studi' => TblBidangStudi::count(),
            'Data Jadwal Pelajaran' => TblRoster::count(),
            'Data Pegawai' => TblPegawai::count(),
            'Data Prestasi' => TblPrestasi::count(),
            'Data Ekstrakurikuler' => TblEkstrakurikuler::count(),
            'Data Fasilitas' => TblFasilitas::count(),
            'Data Berita' => TblBerita::count(),
        ];

        $props = compact('page', 'dashboardData');

        return Inertia::render('Guru/Dashboard/Index', $props);
    }
}
