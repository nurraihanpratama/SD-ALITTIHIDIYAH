<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TblTahunAjaran extends Model
{
    use HasFactory;
    protected $table = 'tbl_tahun_ajarans';
    protected $primaryKey = 'id';
    public $timestamps = false;
}