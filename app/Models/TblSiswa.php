<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblSiswa extends Model
{
    use HasFactory;

    public function kelas()
    {
        return $this->belongsTo(TblKelas::class, 'id_kelas', 'id_kelas');
    }

    public function status()
    {
        return $this->belongsTo(DataStatus::class, "status_siswa");
    }

    public function jk()
    {
        return $this->belongsTo(JenisKelamin::class, "jk_siswa");
    }
}
