<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class TblAkun extends Authenticatable
{
    use HasFactory, HasApiTokens, Notifiable;

        /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'nama',
        'nama_lengkap',
        'email',
        'role',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',

    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
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
}
