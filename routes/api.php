<?php

use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['auth:sanctum', 'admin'])->group(function(){
    // user routes
    Route::get('/user', [AuthController::class, 'getUser']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // product routes
    Route::apiResource('products', ProductController::class);
});

Route::post('/login', [AuthController::class, 'login']);