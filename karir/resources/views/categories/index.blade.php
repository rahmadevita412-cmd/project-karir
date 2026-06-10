@extends('layouts.admin')

@section('content')


<h1>Data Categories</h1>

<a href="/admin/categories/create" class="btn btn-primary">
    + Tambah Kategori
</a>

<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Nama Kategori</th>
        <th>Aksi</th>
    </tr>

    @foreach($categories as $category)
    <tr>
        <td>{{ $category->id }}</td>
        <td>{{ $category->name }}</td>
        <td>
    <a href="/admin/categories/{{ $category->id }}/edit">
        Edit
    </a>

    <form action="/admin/categories/{{ $category->id }}"
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