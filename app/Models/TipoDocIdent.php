<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoDocIdent extends Model
{
    use HasFactory;
    protected $primaryKey = 'ID';
    protected $table = 'tipo_doc_ident';
    public $timestamps = false;
    
    protected $guarded = [];
}
