<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\api\PakaianController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::post('/pakaian', [PakaianController::class, 'store']);
Route::put('/pakaian/{id}', [PakaianController::class, 'update']);
Route::put('/pakaian/status/{id}', [PakaianController::class, 'updateStatus']);
Route::delete('/pakaian/{id}', [PakaianController::class, 'delete']);
Route::get('/pakaian', [PakaianController::class, 'index']);
Route::get('/pakaian/{id}', [PakaianController::class, 'show']);