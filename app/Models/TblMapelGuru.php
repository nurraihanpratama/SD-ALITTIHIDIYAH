<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblMapelGuru extends Model
{
    use HasFactory;

	protected $table = 'tbl_mapel_gurus';

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
        return $this->belongsTo(TblGuru::class, 'id_guru');
    }

    public function bidangStudi()
    {
        return $this->belongsTo(TblBidangStudi::class, 'id_mapel');
    }

    public function rosters()
    {
        return $this->hasMany(TblRoster::class, 'mapel_guru');
    }

}
