<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblWaliSiswa extends Model
{
    use HasFactory;
	protected $table = 'tbl_wali_siswas';
    protected $primaryKey = 'id_wali';

            // * FILTERS
	public function scopeWithSearch($query, $search, $guard = 'web')
	{
		if ($guard === 'web') {
			$query->when(isset($search['v']), function ($q) use ($search) {
				$q->where($search['f'], 'like', '%' . $search['v'] . '%');
			});
		}
		
	}


	public function siswa()
	{
		return $this->belongsTo(TblSiswa::class, "nisn", 'nisn');
	}

}
