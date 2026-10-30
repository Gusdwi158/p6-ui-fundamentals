# Course Explorer v2 - State Management & Architecture

Praktikum Pertemuan 6 Pemrograman Mobile: Penerapan Provider dan Pemisahan Tanggung Jawab Arsitektur (Separation of Concerns).

## Identitas Mahasiswa
- **Nama:** I Kadek Agus Dwi Adnyana
- **NIM:** 2415051076
- **Kelas:** PTI 5 A

## Alur Dependensi (Dependency Direction)
Presentation (Screens & Widgets) -> Provider -> Repository -> Service/Data Source

## Tanggung Jawab Struktur Folder
- `lib/models/`: Berisi representasi entitas data (`Course`) dan fungsi serialisasi/deserialisasi JSON (`fromJson`).
- `lib/services/`: Mengelola komunikasi langsung dengan sumber data (membaca aset JSON lokal via `rootBundle` atau protokol API).
- `lib/repositories/`: Menyediakan lapisan abstraksi data antara `CourseProvider` dan sumber data teknis.
- `lib/providers/`: Mengelola *shared state*, siklus status asynchronous (*loading*, *error*, *data*), dan memancarkan notifikasi perubahan via `notifyListeners()`.
- `lib/screens/`: Mengatur tata letak tampilan halaman aplikasi secara utuh dan responsif (`HomePage`, `CourseDetailPage`, `FavoritesPage`).
- `lib/widgets/`: Menyediakan komponen antarmuka modular yang dapat digunakan kembali (`CourseCard`).