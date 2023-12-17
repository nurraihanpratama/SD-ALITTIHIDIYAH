<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Sushi\Sushi;

class DataAgama extends Model
{
    use Sushi;

    public $incrementing = false;

	protected $keyType = 'string';
    protected $rows = [
        ['id' => 'Islam', 'name' => "ISLAM"],
        ['id' => 'Kristen', 'name' => "KRISTEN"],
    ];
}