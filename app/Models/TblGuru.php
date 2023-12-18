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

}
