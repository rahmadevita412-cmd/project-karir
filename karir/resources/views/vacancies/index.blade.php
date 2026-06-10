@extends('layouts.admin')

@section('content')

<h1>Data Vacancies</h1>


<a href="/admin/vacancies/create" class="btn btn-primary">
    + Tambah vacancies
</a>

<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Category</th>
        <th>Company</th>
        <th>Job Type</th>
        <th>Salary</th>
        <th>Aksi</th>
    </tr>

    @foreach($vacancies as $vacancy)
    <tr>
        <td>{{ $vacancy->id }}</td>
        <td>{{ $vacancy->title }}</td>
        <td>{{ $vacancy->category->name }}</td>
        <td>{{ $vacancy->company->name }}</td>
        <td>{{ $vacancy->job_type }}</td>
        <td>{{ $vacancy->salary }}</td>
        <td>
    <a href="/admin/vacancies/{{ $vacancy->id }}/edit">
        Edit
    </a>

    <form action="/admin/vacancies/{{ $vacancy->id }}"
          method="POST"
          style="display:inline;">
        @csrf
        @method('DELETE')

        <button type="submit">
            Hapus
        </button>
    </form>
</td>
    </tr>
    @endforeach

</table>

@endsection