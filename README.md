# Project Karir

## Deskripsi Aplikasi

Aplikasi Karier adalah aplikasi pencarian lowongan pekerjaan berbasis Flutter dan Laravel REST API. Aplikasi ini memungkinkan pengguna untuk registrasi, login, melihat lowongan pekerjaan, mengirim lamaran, mengunggah resume PDF, dan menerima notifikasi.


Aplikasi ini memungkinkan pengguna untuk:

- Registrasi akun
- Login dan Logout
- Melihat profil pengguna
- Melihat kategori pekerjaan
- Melihat daftar perusahaan
- Melihat lowongan pekerjaan
- Mengirim lamaran pekerjaan (Apply Job)
- Upload Resume (PDF)
- Menerima notifikasi setelah berhasil melamar pekerjaan

Selain itu tersedia Web Admin untuk mengelola data:

- Categories
- Companies
- Vacancies
- Users
- Applications
- Elements

Data yang dikelola pada Web Admin akan ditampilkan secara otomatis pada aplikasi Flutter melalui REST API.

---

# Teknologi yang Digunakan

## Backend

- Laravel 12
- Laravel Sanctum
- MySQL
- REST API

## Frontend

- Flutter
- Dart
- HTTP Package
- SharedPreferences

---

# Struktur Repository

Repository ini terdiri dari:

```text
project-karir
│
├── Karir
│   └── Backend Laravel
│
├── Responsi3
│   └── Flutter App
│
└── README.md
```

---

# Cara Menjalankan Backend Laravel

## 1. Masuk ke Folder Backend

```bash
cd Karir
```

## 2. Install Dependency

```bash
composer install
```

## 3. Copy File Environment

```bash
cp .env.example .env
```

## 4. Generate Application Key

```bash
php artisan key:generate
```

## 5. Konfigurasi Database

Sesuaikan file `.env`

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=karir_db
DB_USERNAME=root
DB_PASSWORD=
```

## 6. Jalankan Migration

```bash
php artisan migrate
```

## 7. Jalankan Laravel

```bash
php artisan serve
```

Backend berjalan pada:

```text
http://127.0.0.1:8000
```

---

# Konfigurasi Database

Database yang digunakan:

```text
karir_db
```

Database dijalankan menggunakan MySQL pada Laragon.

---

# Cara Menjalankan Flutter

## 1. Masuk ke Folder Flutter

```bash
cd Responsi3
```

## 2. Install Dependency

```bash
flutter pub get
```

## 3. Jalankan Aplikasi

```bash
flutter run
```

---

# Konfigurasi API Flutter

Pastikan URL API mengarah ke backend Laravel.

Jika menggunakan browser:

```dart
const String baseUrl = 'http://127.0.0.1:8000/api';
```

Jika menggunakan Android Emulator:

```dart
const String baseUrl = 'http://10.0.2.2:8000/api';
```

---

# Endpoint API

## Authentication

### Register

```http
POST /api/register
```

### Login

```http
POST /api/login
```

### Logout

```http
POST /api/logout
```

### Profile

```http
GET /api/profile
```

---

## Categories

```http
GET /api/categories
```

---

## Companies

```http
GET /api/companies
```

---

## Vacancies

```http
GET /api/vacancies
```

---

## Apply Job

```http
POST /api/apply
```

Authorization:

```text
Bearer Token
```

---

## Notifications

```http
GET /api/notifications
```

Authorization:

```text
Bearer Token
```

---

## Elements

```http
GET /api/elements
```

---

# Fitur Web Admin

Web Admin digunakan untuk mengelola data aplikasi.

Fitur yang tersedia:

- Dashboard Admin
- CRUD Categories
- CRUD Companies
- CRUD Vacancies
- CRUD Users
- CRUD Applications
- CRUD Elements

URL Admin:

```text
http://127.0.0.1:8000/admin
```

---

# Alur Sistem

1. User melakukan registrasi akun.
2. User login menggunakan email dan password.
3. Laravel Sanctum membuat token autentikasi.
4. Flutter menyimpan token menggunakan SharedPreferences.
5. User dapat melihat kategori, perusahaan, dan lowongan pekerjaan.
6. User mengirim lamaran pekerjaan dan mengunggah resume PDF.
7. Data lamaran disimpan ke database.
8. Sistem membuat notifikasi otomatis.
9. User dapat melihat notifikasi pada halaman Notification.
10. Admin dapat mengelola seluruh data melalui Web Admin.

---

# Akun Login

## User

Email:

```text
caca@gmail.com
```

Password:

```text
123456789
```

---

