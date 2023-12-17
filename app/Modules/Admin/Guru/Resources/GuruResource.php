<?php

namespace App\Modules\Admin\Guru\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Request;

class GuruResource extends JsonResource
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
