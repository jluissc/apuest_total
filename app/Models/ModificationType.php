<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ModificationType extends Model
{
    use HasFactory;
    protected $table = 'modification_type';
    public $timestamps = false;

    protected $guarded = [];
}
