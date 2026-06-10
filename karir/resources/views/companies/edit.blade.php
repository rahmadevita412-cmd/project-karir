@extends('layouts.admin')

@section('content')


<h1>Edit Company</h1>

<form action="/admin/companies/{{ $company->id }}" method="POST">
    @csrf
    @method('PUT')

    <label>Nama Company</label><br>
    <input type="text"
           name="name"
           value="{{ $company->name }}"><br><br>

    <label>Location</label><br>
    <input type="text"
           name="location"
           value="{{ $company->location }}"><br><br>

    <label>Vacancy Count</label><br>
    <input type="number"
           name="vacancy_count"
           value="{{ $company->vacancy_count }}"><br><br>

    <button type="submit">
        Update
    </button>

</form>

@endsection