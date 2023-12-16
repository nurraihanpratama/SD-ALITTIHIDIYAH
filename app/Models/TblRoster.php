<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblRoster extends Model
{
    use HasFactory;


    public function kelas()
    {
        return $this->belongsTo(TblKelas::class, 'kelas', 'id_kelas');
    }

    public function guru()
    {
        return $this->belongsToMany(TblGuru::class, 'tbl_mapel_gurus', 'id_guru', 'id_mapel');
    }
}
