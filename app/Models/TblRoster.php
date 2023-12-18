<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblRoster extends Model
{
    use HasFactory;
    protected $table = 'tbl_rosters';
    protected $primaryKey = 'roster_id';

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
        return $this->belongsTo(TblKelas::class, 'kelas', 'id_kelas');
    }

    public function guru()
    {
        return $this->belongsToMany(TblGuru::class, 'tbl_mapel_gurus', 'id_guru', 'id_mapel');
    }
}
