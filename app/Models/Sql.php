<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sql extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'T_BASE_BCA_PER';
 
}
