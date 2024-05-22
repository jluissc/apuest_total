<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UbicPersComerc extends Model
{
    use HasFactory;
    protected $primaryKey = 'ID';
    protected $table = 'ubi_pers_com';
    public $timestamps = false;
    
    protected $guarded = [];
    public function persona_comercial()
    {
        return $this->belongsTo(PersonaComercial::class, 'ID_PERS_COM');
    }

    public function ubicac(){
        return $this->belongsTo(UbicacionComercial::class, 'ID_UBIC');
    }
    
}
