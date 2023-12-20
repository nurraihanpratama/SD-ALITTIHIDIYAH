<?php

namespace App\Modules\MyProfile\Actions;

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Models\User;

class MyProfileUpdatePasswordAction
{
	public function update($request,  $id)
	{
		try {
			// dd($request);

			$user = User::findOrFail($id);

			if (!Hash::check($request->current_password, $user->password)) {
				return back()->withErrors('Password saat ini tidak sesuai!');
			}

			DB::transaction(function () use ($request, $user) {
				// *** START ***

				$user->update([
					'password' => Hash::make($request->password)
				]);

				// *** DONE ***
			});
			return back()->withFlash('Berhasil update profile');
		} catch (\Throwable $th) {
			saveErrorLog($th, __FILE__);
			return back()->withErrors(config('app.error_msg'));
		}
	}
}
