<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PayModify extends Model
{
    use HasFactory;
    
    protected $table = 'pay_modify';
    public $timestamps = true;

    protected $guarded = [];
}
