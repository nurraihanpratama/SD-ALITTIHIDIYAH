<?php

namespace App\Modules\Admin\BidangStudi\Tables;

use App\Models\TblBidangStudi;
use App\Modules\Admin\BidangStudi\Resources\BidangStudiResource;

class BidangStudiDataTable
{
    public function generate($request)
    {
        $data = TblBidangStudi::query()
                ->paginate(15);

        $collection = BidangStudiResource::collection($data);

        return $collection;
    }
}