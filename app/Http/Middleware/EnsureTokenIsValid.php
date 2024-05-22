<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EnsureTokenIsValid
{
    public function handle($request, Closure $next)
    {
        if (Auth::check() && Auth::user()->tokenExpired()) {
            Auth::logout();
            return redirect()->route('login')->with('error', 'Tu sesión ha caducado. Por favor, inicia sesión de nuevo.');
        }

        return $next($request);
    }
}
