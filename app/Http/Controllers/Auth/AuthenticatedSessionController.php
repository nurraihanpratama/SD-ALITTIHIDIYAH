<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;
use Inertia\Response;

class AuthenticatedSessionController extends Controller
{
    /**
     * Display the login view.
     */
    public function create(): Response
    {
        return Inertia::render('Auth/Login', [
            'canResetPassword' => Route::has('password.request'),
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request): RedirectResponse
    {
        $request->authenticate();

        $request->session()->regenerate();

        $validator = Validator::make($request->all(), [
            'username' => 'required|exists:user',
            'password' => 'required|min:6',
            'kurikulum' => 'required',
            'tahun_pelajaran' => 'required',
        ]);

        
        if(auth()->user()->role == 'admin')
        {
            return redirect()->intended(RouteServiceProvider::ADMIN);
        }
        if(auth()->user()->role == 'auru')
        {
            return redirect()->intended(RouteServiceProvider::GURU);
        }
        if(auth()->user()->role == 'aiswa')
        {
            return redirect()->intended(RouteServiceProvider::SISWA);
        }


    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/login');
    }
}
