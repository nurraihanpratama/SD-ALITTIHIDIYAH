<?php

namespace App\Modules\Admin\BidangStudi\Tables;

use App\Models\TblBidangStudi;
use App\Modules\Admin\BidangStudi\Resources\BidangStudiResource;

class BidangStudiDataTable
{
    public function generate($request)
    {
        
        $search = $request->get('search');
        $data = TblBidangStudi::query()
                ->withSearch($search)
                ->paginate(15)
                ->appends([
                    'search' => $search,
                ]);


        $collection = BidangStudiResource::collection($data);

        return $collection;
    }
}