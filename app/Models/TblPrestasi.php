<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblPrestasi extends Model
{
    use HasFactory;
	protected $table = 'tbl_prestasis';
    protected $primaryKey = 'id_prestasi';
	protected $fillable = [
		'nama_prestasi',
		'deskripsi'
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

}
