<?php

namespace App\Modules\Siswa\Dashboard\Actions;

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

class SiswaDashboardIndexAction
{
    public function index($request)
    {
        $page = [
            "title" => "Dashboard"
        ];

        // ... sesuaikan dengan kebutuhan Anda untuk mendapatkan data dashboard
        $dashboardData = [
            'Data Kelas' => TblKelas::count(),
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

        return Inertia::render('Siswa/Dashboard/Index', $props);
    }
}
