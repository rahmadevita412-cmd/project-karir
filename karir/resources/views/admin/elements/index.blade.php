@extends('layouts.admin')

@section('content')

<h1>Elements</h1>

<form method="POST" action="/admin/elements">
    @csrf

    <input type="text"
           name="title"
           placeholder="Nama Element">

    <button type="submit">
        Tambah
    </button>
</form>

<br>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
    </tr>

    @foreach($elements as $element)
    <tr>
        <td>{{ $element->id }}</td>
        <td>{{ $element->title }}</td>
    </tr>
    @endforeach

</table>

@endsection