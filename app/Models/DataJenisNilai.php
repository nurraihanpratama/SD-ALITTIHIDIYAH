<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Sushi\Sushi;

class DataJenisNilai extends Model
{
    use Sushi;

    public $incrementing = false;

	protected $keyType = 'string';
    protected $rows = [
        ['id' => 'uh1', 'name' => "Ulangan Harian 1"],
        ['id' => 'uh2', 'name' => "Ulangan Harian 2"],
        ['id' => 'uh3', 'name' => "Ulangan Harian 3"],
        ['id' => 'uts', 'name' => "Ujian Tengah Semester"],
        ['id' => 'uas', 'name' => "Ujian Akhir Semester"],
    ];
}