<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class rental extends Model
{
    use HasFactory;
    protected $table = 'rentals';
    protected $primaryKey = 'id';
    protected $fillable =[
        'user_id',
        'costume_id',
        'start_date',
        'end_date',
        'status',
    ];
    public function users(){
        return $this->belongsTo(User::class, 'id');
    }
    public function costumes(){
        return $this->belongsTo(costume::class, 'id');
    }
}
