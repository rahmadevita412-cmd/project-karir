<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    protected $fillable = [
        'name',
        'location',
        'vacancy_count'
    ];

    public function vacancies()
    {
        return $this->hasMany(Vacancy::class);
    }
}