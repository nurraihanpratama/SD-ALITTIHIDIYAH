<?php

namespace App\Modules\MyProfile\Controllers;

use App\Modules\MyProfile\Actions\MyProfileUpdatePasswordAction;
use App\Modules\MyProfile\Requests\UpdatePasswordRequest;
use App\Modules\MyProfile\Actions\MyProfileUpdateAction;
use App\Modules\MyProfile\Actions\MyProfileIndexAction;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class MyProfileController extends Controller
{
	public function index(Request $request)
	{
		return (new MyProfileIndexAction)->index($request);
	}

	public function update(Request $request, string $team_slug, string $id)
	{
		return (new MyProfileUpdateAction)->update($request, $id);
	}

	public function updatePassword(
		UpdatePasswordRequest $request,
		string $team_slug,
		string $id
	) {
		return (new MyProfileUpdatePasswordAction)->update($request, $id);
	}
}
