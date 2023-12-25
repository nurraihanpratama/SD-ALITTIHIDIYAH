<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblGuru extends Model
{
    use HasFactory;
    protected $table = 'tbl_gurus';
    protected $primaryKey = 'id_guru';
    public $timestamps = false;
	protected $fillable = [
        'nama_guru',
        'ket_guru',
        'status_guru'
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

    public function kelas()
    {
        return $this->hasOne(TblKelas::class, 'wali_kelas', 'id_guru');
    }

    public function bidangStudis()
    {
        return $this->belongsToMany(TblBidangStudi::class, 'tbl_mapel_gurus', 'id_guru', 'id_mapel');
    }

    public function nilai()
    {
        return $this->hasMany(TblNilai::class, 'id_guru', 'id_guru');
    }

}
