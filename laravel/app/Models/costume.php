<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;

class costume extends Model
{
    use HasFactory;

    protected $table = 'costumes';
    protected $primaryKey = 'id';
    protected $fillable = [
        'name', 'image', 'description', 'status', 'kategori', 'kelamin', 'usia','harga'
    ];
    
}
