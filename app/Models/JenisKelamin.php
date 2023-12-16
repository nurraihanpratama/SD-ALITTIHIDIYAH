<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Sushi\Sushi;

class JenisKelamin extends Model
{
    use Sushi;

    public $incrementing = false;

	protected $keyType = 'string';
    protected $rows = [
        ['id' => "P", 'name' => 'PEREMPUAN'],
        ['id' => "L", 'name' => 'LAKI-LAKI']
    ];
}