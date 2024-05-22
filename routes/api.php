<?php

use App\Models\Perfil;
use App\Models\PersonaPerfil;
use App\Models\UbicacionComercial;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


