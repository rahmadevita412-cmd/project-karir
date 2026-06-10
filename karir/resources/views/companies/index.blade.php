@extends('layouts.admin')

@section('content')

<h1>Data Companies</h1>


<a href="/admin/companies/create" class="btn btn-primary">
    + Tambah Company
</a>

<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Nama Company</th>
        <th>Location</th>
        <th>Vacancy Count</th>
        <th>Aksi</th>
    </tr>

    @foreach($companies as $company)
    <tr>
        <td>{{ $company->id }}</td>
        <td>{{ $company->name }}</td>
        <td>{{ $company->location }}</td>
        <td>{{ $company->vacancy_count }}</td>
        <td>
            <a href="/admin/companies/{{ $company->id }}/edit">
                Edit
            </a>

            <form action="/admin/companies/{{ $company->id }}"
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