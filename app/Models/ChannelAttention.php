<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChannelAttention extends Model
{
    use HasFactory;
    protected $table = 'channel_attention';
    public $timestamps = false;

    protected $guarded = []; 
}
