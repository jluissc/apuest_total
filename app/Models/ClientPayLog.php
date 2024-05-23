<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClientPayLog extends Model
{
    use HasFactory;
    
    protected $table = 'client_pay_log';
    public $timestamps = false;

    protected $guarded = []; 
}
