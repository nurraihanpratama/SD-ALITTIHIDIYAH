<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblNilai extends Model
{
    use HasFactory;
    protected $table = 'tbl_nilais';
    protected $primaryKey = 'id_nilai';
    
    protected $fillable = [
        'nisn_siswa',
        'jenis_nilai',
        'id_mapel',
        'id_guru',
        'nilai'
    ];

    public function siswa()
    {
        return $this->belongsTo(TblSiswa::class, 'nisn_siswa', 'nisn');
    }

    public function mapel()
    {
        return $this->belongsTo(TblBidangStudi::class, 'id_mapel', 'id_mapel');
    }

    public function guru()
    {
        return $this->belongsTo(TblGuru::class, 'id_guru', 'id_guru');
    }

    public function jenisNilai()
    {
        return $this->belongsTo(DataJenisNilai::class, 'jenis_nilai', 'id');
    }

    public function bidangStudi()
    {
        return $this->belongsTo(TblBidangStudi::class, 'id_mapel', 'id_mapel');
    }
}