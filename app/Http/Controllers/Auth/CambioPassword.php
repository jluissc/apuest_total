<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller; 
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class CambioPassword extends Controller
{
    public function cambioPassword(Request $request){
        /* Validaciones de form */
        $validator = Validator::make($request->all(), [
                'email' => 'required|numeric|min:5',
                'password' => 'required|confirmed',
                // 'password_confirmation' => 'required',
            ],[
                'email.required' => 'Campo obligatorio', 
                'password.confirmed' => 'Contraseñas no coinciden',
            ]);
        if ($validator->fails()) {
            return response()->json([
                'estado' => -1,
                'mensaje' => 'Mal inputs',
                'error' => $validator->errors(),
            ]);
        }
        /* Validaciones de usuario */
        $user = Auth::user();
        if ($user->email == $request->post('email')) {
            /* Editar el usuario */
            $user->password = Hash::make($request->input('password'));;
            $user->save();
            return response()->json([
                'estado' => 1,
                'mensaje' => 'Todobien',
            ]);
        }
        return response()->json([
            'estado' => -1,
            'mensaje' => 'No es el usuario',
        ]);

        

    }
}
