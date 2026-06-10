@extends('layouts.admin')

@section('content')

<h1>Edit Kategori</h1>

<form action="/admin/categories/{{ $category->id }}" method="POST">
    @csrf
    @method('PUT')

    <input type="text"
           name="name"
           value="{{ $category->name }}">

    <br><br>

    <button type="submit">
        Update
    </button>

</form>

@endsection