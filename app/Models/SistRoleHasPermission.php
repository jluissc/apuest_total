<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SistRoleHasPermission extends Model
{
    use HasFactory;
    protected $table = 'role_has_permissions';
    public $timestamps = false;
    
    protected $guarded = [];    
}
