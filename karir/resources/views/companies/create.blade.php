@extends('layouts.admin')

@section('content')


<h1>Tambah Company</h1>

<form action="/admin/companies" method="POST">
    @csrf

    <label>Nama Company</label><br>
    <input type="text" name="name"><br><br>

    <label>Location</label><br>
    <input type="text" name="location"><br><br>

    <label>Vacancy Count</label><br>
    <input type="number" name="vacancy_count"><br><br>

    <button type="submit">Simpan</button>

</form>

@endsection