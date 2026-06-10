<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Application;
use Illuminate\Http\Request;
use App\Models\Notification;

class ApplicationController extends Controller
{
    public function store(Request $request)
{
    $request->validate([
        'vacancy_id' => 'required',
        'phone' => 'required',
        'resume' => 'required|file|mimes:pdf|max:2048'
    ]);

    $resumePath = $request->file('resume')
        ->store('resumes', 'public');

    $application = Application::create([
        'user_id' => $request->user()->id,
        'vacancy_id' => $request->vacancy_id,
        'phone' => $request->phone,
        'resume' => $resumePath,
    ]);
    Notification::create([
    'user_id' => $request->user()->id,
    'title' => 'Lamaran Berhasil',
    'message' => 'Lamaran Anda berhasil dikirim',
]);

    return response()->json([
        'message' => 'Lamaran berhasil dikirim',
        'data' => $application
    ]);
}
}