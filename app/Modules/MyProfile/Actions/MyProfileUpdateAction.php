<?php

namespace App\Modules\MyProfile\Actions;

use Illuminate\Support\Facades\DB;
use App\Models\User;

class MyProfileUpdateAction
{
	public function update($request,  $id)
	{
		try {
			// dd($request);

			$userData = getValidatedData(new User, $request->toArray());

			$userData['user_name'] = str($request->user_name)->title();

			DB::transaction(function () use ($request, $id, $userData) {
				// *** START ***

				$user = User::findOrFail($id);
				$user->update($userData);

				// *** DONE ***
			});
			return back()->withFlash('Berhasil update profile');
		} catch (\Throwable $th) {
			saveErrorLog($th, __FILE__);
			return back()->withErrors(config('app.error_msg'));
		}
	}
}
