<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblKelas extends Model
{
    use HasFactory;
    protected $table = 'tbl_kelas';
    protected $primaryKey = 'id_kelas';
    public $timestamps = false;
    protected $fillable = [
        'nama',
        'wali_kelas',
        'created_at'
        ];


    // * FILTERS
	public function scopeWithSearch($query, $search, $guard = 'web')
	{
		if ($guard === 'web') {
			$query->when(isset($search['v']), function ($q) use ($search) {
				$q->where($search['f'], 'like', '%' . $search['v'] . '%');
			});
		}
		
	}

    public function guru()
    {
        return $this->belongsTo(TblGuru::class ,'wali_kelas' ,'id_guru' );
    }

    public function siswa()
    {
        return $this->hasMany(TblSiswa::class, 'id_kelas', 'id_kelas');
    }

    public function tahunAjaran()
    {
        return $this->belongsTo(TblTahunAjaran::class, 'tahun_ajaran_id');
    }
}
