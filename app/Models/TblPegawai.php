<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblPegawai extends Model
{
    use HasFactory;
	protected $table = 'tbl_pegawais';
    protected $primaryKey = 'id_pegawai';
	protected $fillable = [
		'nama_pegawai',
		'jns_kelamin',
		'ket_pegawai',
		'status_pegawai',
		'created_at',
	];
	public static function boot()
        {
            parent::boot();
    
            self::creating(function ($model) {
                $model->created_at = now();
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
				$q->where($search['f'], 'like', '%' . $search['v'] . '%');
			});
		}
		
	}


	public function status()
    {
        return $this->belongsTo(DataStatus::class, "status_pegawai");
    }

    public function jk()
    {
        return $this->belongsTo(JenisKelamin::class, "jns_kelamin");
    }

}
