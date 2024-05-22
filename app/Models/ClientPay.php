<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClientPay extends Model
{
    use HasFactory;
    protected $table = 'client_pay';
    public $timestamps = false;

    protected $guarded = []; 
}
