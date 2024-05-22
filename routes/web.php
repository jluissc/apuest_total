<?php

use App\Http\Controllers\ClientController;
use App\Http\Controllers\PayClientController;
use Illuminate\Support\Facades\Route;


// employed add amount account user
Route::resource('deposito', PayClientController::class);
Route::resource('cliente', ClientController::class);

Route::any('{any}', function () {
    /* return view('errors.404', [
        'tipo' => 'Pagina',
        'mensaje' => 'Ingreso no permitido',
    ]); */
    return 'page not found';
})->where('any', '.*');