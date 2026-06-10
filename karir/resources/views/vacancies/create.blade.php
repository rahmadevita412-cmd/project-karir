@extends('layouts.admin')

@section('content')


<h1>Tambah Vacancy</h1>

<form action="/admin/vacancies" method="POST">
    @csrf

    <label>Category</label><br>
    <select name="category_id">
        @foreach($categories as $category)
            <option value="{{ $category->id }}">
                {{ $category->name }}
            </option>
        @endforeach
    </select>

    <br><br>

    <label>Company</label><br>
    <select name="company_id">
        @foreach($companies as $company)
            <option value="{{ $company->id }}">
                {{ $company->name }}
            </option>
        @endforeach
    </select>

    <br><br>

    <label>Title</label><br>
    <input type="text" name="title">

    <br><br>

    <label>Job Type</label><br>
    <input type="text" name="job_type">

    <br><br>

    <label>Salary</label><br>
    <input type="text" name="salary">

    <br><br>

    <label>Experience</label><br>
    <input type="text" name="experience">

    <br><br>

    <label>Description</label><br>
    <textarea name="description"></textarea>

    <br><br>

    <label>Requirements</label><br>
    <textarea name="requirements"></textarea>

    <br><br>

    <button type="submit">
        Simpan
    </button>

</form>

@endsection