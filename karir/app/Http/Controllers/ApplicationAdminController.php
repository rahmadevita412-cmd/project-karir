<?php

namespace App\Http\Controllers;

use App\Models\Application;

class ApplicationAdminController extends Controller
{
    public function index()
    {
        $applications = Application::with([
            'user',
            'vacancy'
        ])->get();

        return view(
            'applications.index',
            compact('applications')
        );
    }
}