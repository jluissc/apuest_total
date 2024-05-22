<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TypePay extends Model
{
    use HasFactory;
    protected $table = 'tipo_pagos';
    public $timestamps = false;
    
    protected $fillable = [
        'tipo',
        'estado',
    ];

    public function pagos(){
        return $this->hasManyThrough(PagosEntrSalid::class, EntradaSalida::class, 'tipo_pagos_id','pagos_gastos_id');
    }
    
}
