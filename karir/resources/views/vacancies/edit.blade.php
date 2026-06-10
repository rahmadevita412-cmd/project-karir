@extends('layouts.admin')

@section('content')


<h1>Edit Vacancy</h1>

<form action="/admin/vacancies/{{ $vacancy->id }}" method="POST">
    @csrf
    @method('PUT')

    <label>Category</label><br>
    <select name="category_id">
        @foreach($categories as $category)
        <option value="{{ $category->id }}"
            {{ $vacancy->category_id == $category->id ? 'selected' : '' }}>
            {{ $category->name }}
        </option>
        @endforeach
    </select>

    <br><br>

    <label>Company</label><br>
    <select name="company_id">
        @foreach($companies as $company)
        <option value="{{ $company->id }}"
            {{ $vacancy->company_id == $company->id ? 'selected' : '' }}>
            {{ $company->name }}
        </option>
        @endforeach
    </select>

    <br><br>

    <input type="text" name="title" value="{{ $vacancy->title }}">
    <br><br>

    <input type="text" name="job_type" value="{{ $vacancy->job_type }}">
    <br><br>

    <input type="text" name="salary" value="{{ $vacancy->salary }}">
    <br><br>

    <input type="text" name="experience" value="{{ $vacancy->experience }}">
    <br><br>

    <textarea name="description">{{ $vacancy->description }}</textarea>

    <br><br>

    <textarea name="requirements">{{ $vacancy->requirements }}</textarea>

    <br><br>

    <button type="submit">Update</button>

</form>

@endsection