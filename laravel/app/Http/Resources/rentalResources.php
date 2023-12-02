<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class rental extends JsonResource
{
    public function toArray($request)
    {
        return [
            'success' => true,
            'message' => 'List Data Posts',
            'data' => [
                'id' => $this->id,
                'user_id' => $this->user_id,
                'costume_id' => $this->costume_id,
                'start_date' => $this->start_date,
                'end_date' => $this->end_date,
                'status' => $this->status,
                'price' => $this->price,
                'created_at' => $this->created_at,
                'updated_at' => $this->updated_at,
                'deleted_at' => $this->deleted_at,
            ],
        ];
    }
}
