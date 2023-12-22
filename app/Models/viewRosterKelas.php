<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class viewRosterKelas extends Model
{
    use HasFactory;

    protected $table = 'rosterKelas';

    public function kelas()
    {
        return $this->belongsTo(TblKelas::class, 'nama_kelas');
    }
}
