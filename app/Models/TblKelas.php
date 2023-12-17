<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblKelas extends Model
{
    use HasFactory;

    public function guru()
    {
        return $this->belongsTo(TblGuru::class ,'wali_kelas' ,'id_guru' );
    }

    public function siswa()
    {
        return $this->hasMany(TblSiswa::class, 'id_kelas', 'id_kelas');
    }
}
