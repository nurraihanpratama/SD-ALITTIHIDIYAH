<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Sushi\Sushi;

class UserStatus extends Model
{
    use Sushi;

public $incrementing = false;

protected $keyType = 'string';

protected $rows = [
    ['id' => 'active', 'name' => 'ACTIVE', 'css' => 'green-pill'],
    ['id' => 'nonactive', 'name' => 'NONACTIVE', 'css' => 'red-pill'],
];
}



