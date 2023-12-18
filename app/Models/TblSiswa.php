<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblSiswa extends Model
{
    use HasFactory;

    protected $table = 'tbl_siswas';
    protected $primaryKey = 'nisn';
    public $timestamps = false;
    protected $fillable = [
        'nisn',
        'nipd',
        'nama_siswa',
        'jk_siswa',
        'agama_siswa',
        'tempat_lahir',
        'tanggal_lahir',
        'status_siswa',
        'id_kelas',
        'created_at'
        ];

        public static function boot()
        {
            parent::boot();
    
            self::creating(function ($model) {
                $model->created_at       = now();
            });
    
            self::created(function ($model) {
                $model->created_at = now();
            });
    
            self::updating(function ($model) {
                $model->updated_at = now();
            });
    
            self::updated(function ($model) {
                $model->updated_at = now();
            });
        }
        // * FILTERS
	public function scopeWithSearch($query, $search, $guard = 'web')
	{
		if ($guard === 'web') {
			$query->when(isset($search['v']), function ($q) use ($search) {
                if($search['f'] === 'id_kelas'){
                    $q->whereHas('kelas', function($qry) use($search){
                        $qry->where('id_kelas', 'like', '%' . $search['v'] . '%')
                            ->orWhere('nama', 'like', '%' . $search['v'] . '%');
                    });
                }
				$q->where($search['f'], 'like', '%' . $search['v'] . '%');

			});
		}
		
	}

	public function scopeWithSort(
		$query,
		$sort,
		$defaultField = 'created_at',
		$defaultDirection = 'desc'
	) {
		$query->when($sort, function ($q) use ($sort) {
			$q->orderBy($sort['f'], $sort['d']);
		}, function ($q) use ($defaultField, $defaultDirection) {
			return $q->orderBy($defaultField, $defaultDirection);
		});
	}

	public function scopeWithFilter($query, $filter, $field)
	{
		$query->when($filter, function ($q) use ($filter, $field) {
			$q->whereIn($field, makeArray($filter));
		});
	}
    public function kelas()
    {

        return $this->belongsTo(TblKelas::class, 'id_kelas', 'id_kelas');
        // ->as('kelas');
    }

    public function status()
    {
        return $this->belongsTo(DataStatus::class, "status_siswa");
    }

    public function jk()
    {
        return $this->belongsTo(JenisKelamin::class, "jk_siswa");
    }

    public function agama()
    {
        return $this->belongsTo(DataAgama::class, 'agama_siswa');
    }
}
