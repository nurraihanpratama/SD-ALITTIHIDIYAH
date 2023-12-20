<?php

namespace App\Modules\MyProfile\Actions;

use App\Modules\Customer\Models\CountryCode;
use Illuminate\Http\Request;
use Inertia\Inertia;

class MyProfileIndexAction
{
	public function index(Request $request)
	{
		$page = [
			'title' => 'My Profile',
		];


		$props = compact('page');

		return Inertia::render('Admin/MyProfile/Index', $props);
	}
}
