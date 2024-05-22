<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SistPermission extends Model
{
    use HasFactory;
    // protected $primaryKey = 'ID';
    protected $table = 'permissions';
    public $timestamps = false;

    protected $guarded = [];  

    public function area(){
        return $this->belongsTo(Area::class, 'area_id');
    }
}
