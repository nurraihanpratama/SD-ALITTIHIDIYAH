<?php

namespace App\Http\Middleware;

use App\Providers\RouteServiceProvider;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class RedirectIfAuthenticated
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, string ...$guards): Response
    {
        $guards = empty($guards) ? [null] : $guards;

        foreach ($guards as $guard) {
            if (Auth::guard($guard)->check()) {
                if(auth()->user()->role == 'Admin'){
                    return redirect(RouteServiceProvider::ADMIN);
                }
                if(auth()->user()->role == 'Guru'){
                    return redirect(RouteServiceProvider::GURU);
                }
                if(auth()->user()->role == 'Siswa'){
                    return redirect(RouteServiceProvider::SISWA);
                }
            }
        }

        return $next($request);
    }
}
