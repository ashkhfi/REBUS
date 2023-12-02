<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class costumeResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $type = $this->type;
        return [
            'name' => $this->name,
            'description' => $this->description,
            'status' => $this->status,
            'type' => $this->type->type_name,
            'color' => $this->color,
            'size' => $this->size
        ];
    }
}
