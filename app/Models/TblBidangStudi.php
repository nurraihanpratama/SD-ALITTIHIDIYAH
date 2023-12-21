<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblBidangStudi extends Model
{
    use HasFactory;

	protected $table = 'tbl_bidang_studis';
    protected $primaryKey = 'id_mapel';
	protected $fillable = [
		'nama_mapel',
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

	public function gurus()
    {
        return $this->belongsToMany(TblGuru::class, 'tbl_mapel_gurus', 'id_mapel', 'id_guru');
    }

}
