<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SistRole extends Model
{
    use HasFactory;
    protected $primaryKey = 'id';
    protected $table = 'roles';
    public $timestamps = false;
    
    protected $guarded = [];

    public function permisos(){
        return $this->belongsToMany(SistModelHasPermissions::class, 'role_id');
    }
    public function user_roles(){
        return $this->belongsToMany(SistModelHasRoles::class, 'role_id');
    }
}
