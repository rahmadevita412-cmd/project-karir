@extends('layouts.admin')

@section('content')

<h1>Tambah Kategori</h1>

<form action="/admin/categories" method="POST">
    @csrf

    <label>Nama Kategori</label>
    <br><br>

    <input type="text" name="name">

    <br><br>

    <button type="submit">Simpan</button>

</form>

@endsection