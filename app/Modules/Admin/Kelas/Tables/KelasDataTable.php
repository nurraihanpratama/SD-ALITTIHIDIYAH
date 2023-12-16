<?php

<<<<<<< HEAD
namespace App\Modules\Admin\Siswa\Tables;

use App\Models\TblSiswa;
use App\Modules\Admin\Siswa\Resources\SiswaResource;

class SiswaDataTable
{
    public function generate($request)
    {
        $data = TblSiswa::query()
                ->paginate(15);

        $collection = SiswaResource::collection($data);
=======
namespace App\Modules\Admin\Kelas\Tables;

use App\Models\TblKelas;
use App\Modules\Admin\Kelas\Resources\KelasResource;

class KelasDataTable
{
    public function generate($request)
    {
        $data = TblKelas::query()
                ->with(['guru'])
                ->paginate(15);

        $collection = KelasResource::collection($data);
>>>>>>> 1a9f74acd7841630c92fb6e4c77339c90c14f362

        return $collection;
    }
}