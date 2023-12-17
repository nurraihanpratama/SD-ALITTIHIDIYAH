<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Sushi\Sushi;

class KeteranganGuru extends Model
{
    use Sushi;

    public $incrementing = false;

	protected $keyType = 'string';
    protected $rows = [

        ['id' => "PNS", 'name' => 'PNS'],
        ['id' => 'Non-PNS', 'name' => 'NON-PNS'],
        ['id' => 'GTT Komite', 'name' => 'GTT KOMITE']
    ];

}
