<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Pakaian extends Model
{
    use SoftDeletes;

    protected $fillable = ['nama', 'image', 'deskripsi', 'kategori', 'kelamin', 'usia', 'status', 'harga'];

    protected $dates = ['deleted_at'];
}
