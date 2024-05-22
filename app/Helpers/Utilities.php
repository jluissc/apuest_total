<?php

namespace App\Helpers;

use Hamcrest\Core\IsTypeOf;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Utilities {
    public static function responseFetchResolve($message, $data = []){
        if ($data == []) {
            return response()->json([
                'estado' => true,
                'mensaje' => $message,
            ], 200);
        }
        return response()->json([
            'estado' => true,
            'mensaje' => $message,
            'data' => $data,
        ], 200);
    }

    public static function loadFileServer()
    {
        return 0;
    }
    public static function responseFetchReject($message='Contacte con TI', $errors = []){
        if ($errors != []) {
            return response()->json([
                'estado' => false,
                'mensaje' => $message,
                'errors' => $errors,
            ]);
        }
        return response()->json([
            'estado' => false,
            'mensaje' => $message,
        ]);
    }
    public static function responseFetchRejected($errors){
        if (is_string($errors)) {
            $errors = [
                'error' => $errors
            ];
        }

        return response()->json([
            'estado' => false,
            'errors' => $errors,
        ]);

    }


    public static function setSession($request, $clave, $valor)
    {
        $request->session()->put($clave, $valor);
    }

    public static function getSesion($request, $clave)
    {
        return $request->session()->get($clave);
    }

    public static function perfilLogin(){
        return Auth::user()->personaPerfil;
    }

    static function listPersonalXJefe($idJefe){
        return DB::select('EXEC SP_GENERAL_LIST_PERS_X_JEFE ?', [$idJefe]);
    }

    public static function isComercialProspTrackingAllowedHeadAmount() {
        return in_array(Auth::user()->personaPerfil->perfil->ID_TIPO_PERFIL, [1,2,3,5]);
    }

    public static function isComercialProspTrackingAllowedHeadSubproduct() {
        return in_array(Auth::user()->personaPerfil->perfil->ID_TIPO_PERFIL, [1,2,3,5]);
    }

    public static function isComercialProspTrackingAllowedHeadTipRech() {
        return in_array(Auth::user()->personaPerfil->perfil->ID_TIPO_PERFIL, [1,2,3,5]);
    }

    public static function isComercialProspTrackingAllowedHeadComment() {
        return in_array(Auth::user()->personaPerfil->perfil->ID_TIPO_PERFIL, [1,2,3,5]);
    }
}
