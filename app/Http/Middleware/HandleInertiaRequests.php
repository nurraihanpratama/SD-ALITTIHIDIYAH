<?php

namespace App\Http\Middleware;

use App\Models\TblAkun;
use App\Models\TblSiswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Inertia\Middleware;
use Tightenco\Ziggy\Ziggy;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that is loaded on the first page visit.
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determine the current asset version.
     */
    public function version(Request $request): string|null
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        return [
            ...parent::share($request),
            'auth' => [
                'user' => $request->user() ? TblAkun::with(['guru'])->find($request->user()->id) : null ,
            ],
            // 'ziggy' => fn () => [
            //     ...(new Ziggy)->toArray(),
            //     'location' => $request->url(),
            // ],
            'app' => [
                'name' => config('app.name'),
                'subname' => $this->getPanelName($request),
                'current_route' => Route::currentRouteName()
            ],
            'response' => $request->session()->get('response')
            
        ];
    }

    public function getPanelName($request)
	{
		if ($request->user()) {
			$current_route = Route::currentRouteName();

			$siswaPanel = ['siswa.dashboard.index', 'siswa.data-nilai.index'];
			$guruPanel = ['guru.dashboard.index', 'guru.data-siswa.index','guru.laporan-nilai.index', 'guru.laporan-nilai.datatable'];

			if (in_array($current_route, $siswaPanel)) return 'SISWA';
			if (in_array($current_route, $guruPanel)) return 'GURU';

			return 'ADMIN';
		}
		return null;
	}
}
