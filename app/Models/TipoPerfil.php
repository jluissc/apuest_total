<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoPerfil extends Model
{
    use HasFactory;
    protected $primaryKey = 'ID';
    protected $table = 'tipo_perfil';
    public $timestamps = false;
    
    protected $guarded = [];
}
