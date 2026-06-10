<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\CompanyController;
use App\Http\Controllers\Api\VacancyController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ApplicationController;
use App\Http\Controllers\Api\NotificationController;
use App\Models\Element;

Route::get('/categories', [CategoryController::class, 'index']);
Route::get('/companies', [CompanyController::class, 'index']);
Route::get('/vacancies', [VacancyController::class, 'index']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::middleware('auth:sanctum')->group(function () {
Route::get('/profile', [AuthController::class, 'profile']);
Route::post('/logout', [AuthController::class, 'logout']);
Route::post('/apply', [ApplicationController::class, 'store']);
});
Route::get('/elements', function () {
    return Element::all();
});
Route::middleware('auth:sanctum')->get(
    '/notifications',
    [NotificationController::class, 'index']
);