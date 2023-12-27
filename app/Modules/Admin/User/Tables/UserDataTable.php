<?php

namespace App\Modules\Admin\User\Tables;

use App\Models\TblAkun;
use App\Models\User;
use App\Modules\Admin\User\Resources\UserResource;
use Illuminate\Support\Facades\Auth;

class UserDataTable
{
    public function generate($request)
    {
        $data = User::query()
                ->with(['status'])
                ->where('id', '!=', Auth::user()->id)
                ->orderBy('username', 'ASC')
                ->paginate();

        $collection = UserResource::collection($data);

        return $collection;
    }
}