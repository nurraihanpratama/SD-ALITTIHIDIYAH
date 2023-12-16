<?php

<<<<<<< HEAD
namespace App\Modules\Admin\Siswa\Resources;
=======
namespace App\Modules\Admin\Kelas\Resources;
>>>>>>> 1a9f74acd7841630c92fb6e4c77339c90c14f362

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Request;

<<<<<<< HEAD
class SiswaResource extends JsonResource
=======
class KelasResource extends JsonResource
>>>>>>> 1a9f74acd7841630c92fb6e4c77339c90c14f362
{

	/**
	 * Transform the resource into an array.
	 *
	 * @return array<string, mixed>
	 */
	public function toArray(Request $request): array
	{
		$data = parent::toArray($request);

		return $data;
	}
}
