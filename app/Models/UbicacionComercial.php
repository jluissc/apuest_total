<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UbicacionComercial extends Model
{
    use HasFactory;
    protected $primaryKey = 'ID';
    protected $table = 'ubicacion_comercial';
    public $timestamps = false;
    
    protected $guarded = [];

    public function grado($grado){
        $zona = UbicacionComercial::find($this->ID);
        if ($grado == 1) {
            if ($this->ID_TIPO_UBIC == 3) {
                $zona = UbicacionComercial::find($zona->ID_UBIC_PADRE);
            }
            return UbicacionComercial::find($zona->ID_UBIC_PADRE)->UBICACION;
        }elseif ($grado == 2) {
            if ($this->ID_TIPO_UBIC == 3) {
                $zona = UbicacionComercial::find($zona->ID_UBIC_PADRE);
            }
            return $zona->UBICACION;
        }else{
            return $zona->UBICACION;
        }
    }
}
