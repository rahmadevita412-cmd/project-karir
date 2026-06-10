<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Element;
use Illuminate\Http\Request;

class ElementController extends Controller
{
    public function index()
    {
        $elements = Element::all();

        return view('admin.elements.index', compact('elements'));
    }

    public function store(Request $request)
    {
        Element::create([
            'title' => $request->title
        ]);

        return back();
    }
}