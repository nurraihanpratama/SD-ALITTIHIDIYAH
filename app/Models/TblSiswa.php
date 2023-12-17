<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblSiswa extends Model
{
    use HasFactory;

    protected $table = 'tbl_siswas';
    public $timestamps = false;
    protected $fillable = [
        'nisn',
        'nipd',
        'nama_siswa',
        'jk_siswa',
        'agama_siswa',
        'tempat_lahir',
        'tanggal_lahir',
        'status_siswa',
        'id_kelas',
        'created_at'
        ];

    public function kelas()
    {

        return $this->belongsTo(TblKelas::class, 'id_kelas', 'id_kelas');
        // ->as('kelas');
    }

    public function status()
    {
        return $this->belongsTo(DataStatus::class, "status_siswa");
    }

    public function jk()
    {
        return $this->belongsTo(JenisKelamin::class, "jk_siswa");
    }

    public function agama()
    {
        return $this->belongsTo(DataAgama::class, 'agama_siswa');
    }
}
