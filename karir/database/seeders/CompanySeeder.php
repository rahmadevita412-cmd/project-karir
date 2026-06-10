<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Company;

class CompanySeeder extends Seeder
{
    public function run(): void
    {
        Company::create([
            'name' => 'Crewmate Studios',
            'location' => 'Medan, Indonesia',
            'vacancy_count' => 40
        ]);

        Company::create([
            'name' => 'Othathink',
            'location' => 'Jakarta, Indonesia',
            'vacancy_count' => 21
        ]);
    }
}
