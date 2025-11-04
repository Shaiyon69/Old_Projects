<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cars extends Model
{
    protected $fillable = [
        'brand',
        'model',
        'color',
        'year',
        'price',
    ];
}
