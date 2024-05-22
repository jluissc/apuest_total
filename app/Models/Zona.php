<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Zona extends Model
{
    use HasFactory;
    protected $primaryKey = 'ID';
    protected $table = 'zona';
    public $timestamps = false;
    
    protected $guarded = [];
    
    public function region(){
        return $this->belongsTo(Region::class, 'ID_REGION');
    }
}
