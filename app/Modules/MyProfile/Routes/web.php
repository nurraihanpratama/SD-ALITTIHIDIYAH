<?php

use App\Modules\MyProfile\Controllers\MyProfileController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| My Profile Web Routes
|--------------------------------------------------------------------------
|
*/

Route::prefix('{team}/')
	->middleware(['auth', 'verified', 'CheckTeamIsExisting'])
	->group(function () {
		Route::post('/my-profile/{user_id}', [MyProfileController::class, 'update'])
			->name('my-profile.update');

		Route::patch('/my-profile/update-password/{user_id}', [MyProfileController::class, 'updatePassword'])
			->name('my-profile.update-password');

		Route::resource('my-profile', MyProfileController::class)
			->only(['index']);
	});
