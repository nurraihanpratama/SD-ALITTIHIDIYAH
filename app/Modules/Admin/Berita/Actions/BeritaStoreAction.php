<?php

namespace App\Modules\Admin\Berita\Actions;

use App\Models\TblBerita;
use App\Traits\ImageUploadAble;
use Illuminate\Support\Facades\DB;

class BeritaStoreAction
{ use ImageUploadAble;

    public function store($request)
    {
        // dd($request);
        try {
            $dataBerita = getValidatedData(new TblBerita, $request->except(['foto_filename']));
            DB::transaction(function() use($dataBerita, $request){
                $dataBerita['id_akun'] = auth()->user()->id;
                
                if($request->foto_img){
                    $dataBerita['foto_filename'] = $this->upload(
                        $request,
                        'foto_img',
                        'storage/upload/berita/foto',
                        null
                    );
                } else {
	
                    unset($dataBerita['foto_filename']);
                }
                // dd($dataBerita);
                TblBerita::create($dataBerita);
            });

            return back()->withFlash('Berhasil Mendaftarkan Siswa Baru');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}