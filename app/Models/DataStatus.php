<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Sushi\Sushi;

class DataStatus extends Model
{
    use Sushi;

    public $incrementing = false;

	protected $keyType = 'string';
    protected $rows = [
        ['id' => "Aktif", 'name' => 'AKTIF'],
        ['id' => "Nonaktif", 'name' => 'NONAKTIF']
    ];
}