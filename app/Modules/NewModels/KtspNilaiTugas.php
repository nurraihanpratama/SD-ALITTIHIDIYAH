<?php

namespace App\Modules\NewModels;

use Illuminate\Database\Eloquent\Model;

class KtspNilaiTugas extends Model
{
    protected $table = 'ktsp_nilai_tugas';
    protected $fillable = [
        'pembelajaran_id',
        'anggota_kelas_id',
        'nilai',
    ];

    public function pembelajaran()
    {
        return $this->belongsTo('App\Pembelajaran');
    }

    public function anggota_kelas()
    {
        return $this->belongsTo('App\AnggotaKelas');
    }
}
