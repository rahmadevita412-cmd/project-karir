@extends('layouts.admin')

@section('content')

<style>
    body{
        background:#f4f6fb;
    }

    h1{
        font-size:40px;
        font-weight:800;
        color:#111827;
        margin-bottom:30px;
    }

    div[style*="display:flex"]{
        gap:25px !important;
        margin-top:20px;
    }

    div[style*="display:flex"] > div{
        width:240px;
        min-height:140px;
        background:#ffffff !important;
        border-radius:20px;
        border-top:6px solid #1d2d74;
        box-shadow:0 10px 25px rgba(29,45,116,0.12);
        transition:all 0.3s ease;
        position:relative;
        overflow:hidden;
    }

    div[style*="display:flex"] > div:hover{
        transform:translateY(-6px);
        box-shadow:0 18px 35px rgba(29,45,116,0.20);
    }

    div[style*="display:flex"] > div::before{
        content:"";
        position:absolute;
        top:-40px;
        right:-40px;
        width:100px;
        height:100px;
        background:rgba(29,45,116,0.08);
        border-radius:50%;
    }

    div[style*="display:flex"] > div h3{
        color:#1d2d74;
        font-size:18px;
        font-weight:700;
        margin-bottom:15px;
    }

    div[style*="display:flex"] > div h2{
        color:#111827;
        font-size:42px;
        font-weight:800;
        margin:0;
    }

    div[style*="display:flex"] > div:nth-child(1){
        border-top:6px solid #1d2d74;
    }

    div[style*="display:flex"] > div:nth-child(2){
        border-top:6px solid #2840a5;
    }

    div[style*="display:flex"] > div:nth-child(3){
        border-top:6px solid #3553d8;
    }

    div[style*="display:flex"] > div:nth-child(4){
        border-top:6px solid #4c69e5;
    }
</style>

<h1>Dashboard Admin</h1>

<div style="display:flex; gap:20px; flex-wrap:wrap;">

    <div style="padding:20px; background:#f5f5f5;">
        <h3>Categories</h3>
        <h2>{{ $totalCategories }}</h2>
    </div>

    <div style="padding:20px; background:#f5f5f5;">
        <h3>Companies</h3>
        <h2>{{ $totalCompanies }}</h2>
    </div>

    <div style="padding:20px; background:#f5f5f5;">
        <h3>Vacancies</h3>
        <h2>{{ $totalVacancies }}</h2>
    </div>

    <div style="padding:20px; background:#f5f5f5;">
        <h3>Users</h3>
        <h2>{{ $totalUsers }}</h2>
    </div>

</div>

@endsection