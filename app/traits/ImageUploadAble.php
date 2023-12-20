<?php

namespace App\Traits;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

trait ImageUploadAble
{

	/**
	 * @param Request $request
	 * @return $this|false|string
	 */
	public function upload(Request $request, $fieldname = 'image', $directory = 'images', $old_file = null)
	{
		if ($request->hasFile($fieldname)) {
			if (!$request->file($fieldname)->isValid()) {
				return back()->withErrors('message', 'cannot save image');
			}

			// delete first old file if exist
			if ($old_file) {
				Storage::delete($directory . '/' . $old_file);
			}

			$file = $request->file($fieldname)->store($directory);
			return basename($file);
		}

		return null;
	}
}