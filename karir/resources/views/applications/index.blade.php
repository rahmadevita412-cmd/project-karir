@extends('layouts.admin')

@section('content')

<h1>Applications</h1>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>User</th>
        <th>Email</th>
        <th>Vacancy</th>
        <th>Phone</th>
        <th>Resume</th>
    </tr>

    @foreach($applications as $application)
    <tr>
        <td>{{ $application->id }}</td>
        <td>{{ $application->user->name }}</td>
        <td>{{ $application->user->email }}</td>
        <td>{{ $application->vacancy->title }}</td>
        <td>{{ $application->phone }}</td>
        <td>
    @if($application->resume)
        <a href="{{ asset('storage/' . $application->resume) }}"
           target="_blank">
            Lihat CV
        </a>
    @else
        Tidak ada CV
    @endif
</td>
    </tr>
    @endforeach

</table>

@endsection