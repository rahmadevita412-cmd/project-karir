<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Company;

class CompanyController extends Controller
{
    public function index()
    {
        $companies = Company::all();

        return view('companies.index', compact('companies'));
    }
    public function create()
{
    return view('companies.create');
}

public function store(Request $request)
{
    Company::create([
        'name' => $request->name,
        'location' => $request->location,
        'vacancy_count' => $request->vacancy_count
    ]);

    return redirect('/admin/companies');
}
public function edit($id)
{
    $company = Company::findOrFail($id);

    return view('companies.edit', compact('company'));
}

public function update(Request $request, $id)
{
    $company = Company::findOrFail($id);

    $company->update([
        'name' => $request->name,
        'location' => $request->location,
        'vacancy_count' => $request->vacancy_count
    ]);

    return redirect('/admin/companies');
}

public function destroy($id)
{
    $company = Company::findOrFail($id);

    $company->delete();

    return redirect('/admin/companies');
}
}