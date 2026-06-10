<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Vacancy;

class VacancySeeder extends Seeder
{
    public function run(): void
    {
        Vacancy::create([
            'category_id' => 3,
            'company_id' => 1,
            'title' => 'Software Engineer',
            'job_type' => 'Full Time',
            'salary' => '8.000.000',
            'experience' => '1 Year',
            'description' => 'Develop and maintain software applications.',
            'requirements' => 'Flutter, Laravel, MySQL'
        ]);

        Vacancy::create([
            'category_id' => 3,
            'company_id' => 2,
            'title' => 'Senior Frontend Programmer',
            'job_type' => 'Full Time',
            'salary' => '10.000.000',
            'experience' => '2 Years',
            'description' => 'Build modern user interfaces.',
            'requirements' => 'Flutter, Dart'
        ]);

        Vacancy::create([
            'category_id' => 1,
            'company_id' => 1,
            'title' => 'Principal UI Designer',
            'job_type' => 'Full Time',
            'salary' => '9.000.000',
            'experience' => '3 Years',
            'description' => 'Create attractive UI/UX designs.',
            'requirements' => 'Figma, Adobe XD'
        ]);
    }
}
