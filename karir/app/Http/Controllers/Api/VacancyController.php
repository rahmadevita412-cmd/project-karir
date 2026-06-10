<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Vacancy;

class VacancyController extends Controller
{
    public function index()
    {
        return response()->json(
            Vacancy::with(['category', 'company'])->get()
        );
    }
}
