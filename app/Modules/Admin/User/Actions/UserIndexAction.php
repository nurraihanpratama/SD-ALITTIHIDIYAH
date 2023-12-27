<?php 

namespace App\Modules\Admin\User\Actions;

use App\Modules\Admin\User\Tables\UserDataTable;
use Inertia\Inertia;

class UserIndexAction
{
    public function index($request)
    {
        $page =[
            'title' => 'Data User',
        ];

        $collection = (new UserDataTable)->generate($request);

        $props = compact('page','collection');

        return Inertia::render('Admin/User/Index', $props);
    }
}