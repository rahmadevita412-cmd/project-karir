<!DOCTYPE html>
<html>
<head>
    <title>Admin Karier</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins',sans-serif;
        }

        body{
            background:#f4f6fb;
        }

        .sidebar{
            width:260px;
            height:100vh;
            background:#16276B;
            position:fixed;
            left:0;
            top:0;
            padding:25px 0;
            box-shadow:4px 0 20px rgba(0,0,0,0.1);
        }

        .logo{
            color:white;
            font-size:28px;
            font-weight:700;
            text-align:center;
            margin-bottom:40px;
        }

        .sidebar a{
            display:block;
            color:white;
            text-decoration:none;
            padding:15px 25px;
            margin:5px 15px;
            border-radius:12px;
            transition:0.3s;
            font-size:15px;
            font-weight:500;
        }

        .sidebar a:hover{
            background:rgba(255,255,255,0.15);
            transform:translateX(5px);
        }

        .content{
            margin-left:260px;
            padding:30px;
        }

        .page-title{
            font-size:34px;
            font-weight:700;
            color:#16276B;
            margin-bottom:25px;
        }

        .card{
    background:white;
    border-radius:18px;
    padding:25px;
    border-left:5px solid #16276B;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

        table{
            width:100%;
            border-collapse:collapse;
            background:white;
            border-radius:15px;
            overflow:hidden;
            box-shadow:0 5px 20px rgba(0,0,0,0.08);
        }

        table th{
            background:#16276B;
            color:white;
            padding:15px;
            text-align:left;
        }

        table td{
            padding:15px;
            border-bottom:1px solid #eee;
        }

        table tr:hover{
            background:#f7f9ff;
        }

        .btn{
            display:inline-block;
            padding:10px 18px;
            border:none;
            border-radius:10px;
            cursor:pointer;
            text-decoration:none;
            font-size:14px;
            font-weight:500;
        }

        .btn-primary{
            background:#16276B;
            color:white;
        }

        .btn-success{
            background:#22c55e;
            color:white;
        }

        .btn-danger{
            background:#ef4444;
            color:white;
        }

        input,
        select,
        textarea{
            width:100%;
            padding:12px;
            border:1px solid #ddd;
            border-radius:10px;
            margin-top:8px;
            margin-bottom:15px;
        }

        .topbar{
            background:white;
            padding:20px;
            border-radius:15px;
            margin-bottom:25px;
            box-shadow:0 5px 20px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

<div class="sidebar">

    <div class="logo">
        Karier Admin
    </div>

    <a href="/admin">Dashboard</a>
    <a href="/admin/categories">Categories</a>
    <a href="/admin/companies">Companies</a>
    <a href="/admin/vacancies">Vacancies</a>
    <a href="/admin/users">Users</a>
    <a href="/admin/applications">Applications</a>
    <a href="/admin/elements">Elements</a>

</div>

<div class="content">
    @yield('content')
</div>

</body>
</html>