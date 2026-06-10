<?php

namespace App\Http\Controllers;

use App\Models\Vacancy;
use App\Models\Category;
use App\Models\Company;
use Illuminate\Http\Request;

class VacancyController extends Controller
{
    public function index()
    {
        $vacancies = Vacancy::with(['category', 'company'])->get();

        return view('vacancies.index', compact('vacancies'));
    }
    public function create()
{
    $categories = Category::all();
    $companies = Company::all();

    return view('vacancies.create', compact('categories', 'companies'));
}

public function store(Request $request)
{
    Vacancy::create([
        'category_id' => $request->category_id,
        'company_id' => $request->company_id,
        'title' => $request->title,
        'job_type' => $request->job_type,
        'salary' => $request->salary,
        'experience' => $request->experience,
        'description' => $request->description,
        'requirements' => $request->requirements
    ]);

    return redirect('/admin/vacancies');
}
public function edit($id)
{
    $vacancy = Vacancy::findOrFail($id);

    $categories = Category::all();
    $companies = Company::all();

    return view('vacancies.edit', compact(
        'vacancy',
        'categories',
        'companies'
    ));
}

public function update(Request $request, $id)
{
    $vacancy = Vacancy::findOrFail($id);

    $vacancy->update([
        'category_id' => $request->category_id,
        'company_id' => $request->company_id,
        'title' => $request->title,
        'job_type' => $request->job_type,
        'salary' => $request->salary,
        'experience' => $request->experience,
        'description' => $request->description,
        'requirements' => $request->requirements
    ]);

    return redirect('/admin/vacancies');
}
public function destroy($id)
{
    $vacancy = Vacancy::findOrFail($id);

    $vacancy->delete();

    return redirect('/admin/vacancies');
}
}