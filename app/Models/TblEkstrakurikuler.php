<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblEkstrakurikuler extends Model
{
    use HasFactory;

	protected $table = 'tbl_ekstrakurikulers';
    protected $primaryKey = 'id_ekskul';

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
