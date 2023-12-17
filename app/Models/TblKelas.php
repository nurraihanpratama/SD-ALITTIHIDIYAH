<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblKelas extends Model
{
    use HasFactory;
    protected $table = 'tbl_kelas';
    public $timestamps = false;
    protected $fillable = [
        'nama',
        'wali_kelas',
        'created_at'
        ];

    public function guru()
    {
        return $this->belongsTo(TblGuru::class ,'wali_kelas' ,'id_guru' );
    }

    public function siswa()
    {
        return $this->hasMany(TblSiswa::class, 'id_kelas', 'id_kelas');
    }
}
