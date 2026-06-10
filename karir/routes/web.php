<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\VacancyController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ApplicationAdminController;
use App\Http\Controllers\Admin\ElementController;
use App\Models\Category;
use App\Models\Company;
use App\Models\Vacancy;
use App\Models\User;





Route::get('/', function () {
    return view('welcome');
});

Route::get('/admin/categories', [CategoryController::class, 'index']);
Route::get('/admin/categories/create', [CategoryController::class, 'create']);
Route::post('/admin/categories', [CategoryController::class, 'store']);
Route::get('/admin/categories/{id}/edit', [CategoryController::class, 'edit']);
Route::put('/admin/categories/{id}', [CategoryController::class, 'update']);
Route::delete('/admin/categories/{id}', [CategoryController::class, 'destroy']);
Route::get('/admin/companies', [CompanyController::class, 'index']);
Route::get('/admin/companies/create', [CompanyController::class, 'create']);
Route::post('/admin/companies', [CompanyController::class, 'store']);
Route::get('/admin/companies/{id}/edit', [CompanyController::class, 'edit']);
Route::put('/admin/companies/{id}', [CompanyController::class, 'update']);
Route::delete('/admin/companies/{id}', [CompanyController::class, 'destroy']);
Route::get('/admin/vacancies', [VacancyController::class, 'index']);
Route::get('/admin/vacancies/create', [VacancyController::class, 'create']);
Route::post('/admin/vacancies', [VacancyController::class, 'store']);
Route::get('/admin/vacancies/{id}/edit', [VacancyController::class, 'edit']);
Route::put('/admin/vacancies/{id}', [VacancyController::class, 'update']);
Route::delete('/admin/vacancies/{id}', [VacancyController::class, 'destroy']);
Route::get('/admin', function () {
    return view('dashboard', [
        'totalCategories' => Category::count(),
        'totalCompanies' => Company::count(),
        'totalVacancies' => Vacancy::count(),
        'totalUsers' => User::count(),
    ]);
});
Route::get('/admin/users', [UserController::class, 'index']);
Route::get(
    '/admin/applications',
    [ApplicationAdminController::class, 'index']
);
Route::get('/admin/elements', [ElementController::class,'index']);
Route::post('/admin/elements', [ElementController::class,'store']);
Route::delete('/admin/elements/{id}', [ElementController::class,'destroy']);