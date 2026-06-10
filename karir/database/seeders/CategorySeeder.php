<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        Category::create([
            'name' => 'Designer'
        ]);

        Category::create([
            'name' => 'Photographer'
        ]);

        Category::create([
            'name' => 'Programmer'
        ]);
    }
}
