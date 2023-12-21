<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblBerita extends Model
{
    use HasFactory;
	protected $table = 'tbl_beritas';
    protected $primaryKey = 'id_berita';
	protected $fillable = [
		'judul',
		'id_akun',
		'foto_filename',
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
