<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubArea extends Model
{
    use HasFactory;
    protected $primaryKey = 'ID';
    protected $table = 'sub_area';
    public $timestamps = false;
    
    protected $guarded = [];
} 
