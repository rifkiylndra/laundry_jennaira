# 🚀 PROGRESS CHECKPOINT: LAUNDRY JENNAIRA MVP (V3.0)
**Durasi:** 4 Minggu (28 Hari Kerja)
**Target Rilis:** [Isi Tanggal Rilis]
**Developer:** Rifki Yuliandra

---

## 🟢 FASE 0: PRE-SPRINT (Setup & Fondasi)
*Target: Selesai sebelum coding hari pertama dimulai.*
- [x] Buat project Supabase (Free tier, region Singapore).
- [x] Jalankan semua DDL SQL di Supabase SQL Editor.
- [x] Seed data: categories (13 default) + settings (tarif dari klien).
- [x] Aktifkan RLS semua tabel + buat policy untuk user `authenticated`.
- [x] Buat project Flutter: `flutter create laundry_jennaira`.
- [x] Tambah semua dependencies di `pubspec.yaml` (supabase_flutter, riverpod, go_router, dll).
- [x] Setup struktur folder `lib/` sesuai arsitektur Feature-First.
- [x] Setup GitHub repo + branching strategy (main/dev).

---

## 🔵 FASE 1: AUTH & ROLE MANAGEMENT (Minggu 1 / H-1 s.d H-7)
*Fokus: Autentikasi dan pemisahan jalur akses Admin vs Kasir.*
- [x] **H-1: Koneksi & Smart Splash Screen**
  - [x] Setup `constants.dart` & Inisialisasi Supabase di `main.dart`.
  - [x] Setup dasar GoRouter dengan 4 tab bottom nav.
  - [x] Buat `theme.dart` (Warna utama `#0F2D5E` dll).
  - [x] Utility: `formatRupiah()`, `formatDate()`, `generateOrderNo()`.
  - [x] Slicing UI Splash Screen.
  - [x] Logika GoRouter: Cek sesi login otomatis.
- [x] **H-2: Login UI & Logic**
  - [x] Slicing UI Login Screen.
  - [x] Implementasi Supabase Auth sign-in (Email + Password).
- [x] **H-3: Role Routing**
  - [x] Fetch data role dari tabel `profiles` saat login berhasil.
  - [x] Arahkan Admin ke `/dashboard`, Kasir ke `/orders`.
- [x] **H-4 s.d H-7: Setup Navigasi Spesifik**
  - [x] Sempurnakan kerangka BottomNavigationBar.
  - [x] Sembunyikan tab Dashboard & Laporan khusus untuk role Kasir.
  - [x] Testing end-to-end alur login dan pembatasan akses.

---

## 🟡 FASE 2: CORE ENGINE & PEMBAYARAN (Minggu 2 / H-8 s.d H-14)
*Fokus: Algoritma harga dinamis dan alur transaksi pelanggan.*
- [x] **H-8: Model & Provider Order**
  - [x] Update `OrderModel` (tambah field `discount`, `is_paid`, `cust_address`).
- [x] **H-9: UI List Order**
  - [x] Slicing UI OrderListScreen (Tab: Aktif / Selesai / Belum Lunas).
- [x] **H-10: Form Buat Order (UI)**
  - [x] Slicing Create Order BottomSheet.
  - [x] Setup input dinamis (Dropdown Satuan, Radio durasi hari).
- [x] **H-11: Pricing Engine (Logic)**
  - [x] Tanamkan logika minimum 1.5kg untuk Express.
  - [x] Tanamkan logika diskon 1kg (Layanan 1 hari > 5kg).
- [x] **H-12: Order Detail**
  - [x] Slicing UI Order Detail (Visual stepper status).
- [x] **H-13: Payment Modal**
  - [x] Buat UI Payment BottomSheet (Tunai/QRIS, input uang diterima).
  - [x] Logika update `is_paid` menjadi true.
- [x] **H-14: Testing W2**
  - [x] Test end-to-end pembuatan order dengan algoritma harga.

---

## 🟠 FASE 3: KEUANGAN & DASHBOARD ADMIN (Minggu 3 / H-15 s.d H-21)
*Fokus: Fitur eksklusif Owner untuk memantau arus kas.*
- [x] **H-15: Transaksi Harian**
  - [x] UI & Logic List Transaksi (Pemasukan/Pengeluaran).
- [x] **H-16: Tambah Pengeluaran**
  - [x] UI & Logic Add Transaksi BottomSheet.
- [x] **H-17 & H-18: Dashboard Analytics**
  - [x] Provider hitung omzet & profit hari ini.
  - [x] Slicing UI Dashboard (Hero cards & Bar Chart).
- [x] **H-19 & H-20: Laporan & Settings**
  - [x] UI Laporan Bulanan & Export.
  - [x] Slicing UI Settings & Inventory stok dasar.
- [x] **H-21: Testing W3**
  - [x] Pastikan Kasir sama sekali tidak bisa mengakses halaman W3.

---

## 🟣 FASE 4: BUG FIXES, OPERATIONAL FEATURES & RELEASE (Minggu 4 / H-22 s.d H-28)
*Fokus: Penyelesaian bug UAT, penambahan fitur operasional (QRIS & Tutup Buku), integrasi perangkat keras, dan serah terima.*

- [x] **H-22: Logic Fixes & Dynamic UI (Menjawab Temuan UAT)**
  - [x] Laporan: Aktifkan fungsionalitas Tab Harian.
  - [x] Laporan: Buat *Custom Date Picker* khusus untuk pemilihan Bulan dan Tahun pada Tab Bulanan.
  - [x] Order: Buat logika *Stepper* dinamis berdasarkan layanan (Cuci Gosok = 4 langkah, Cuci Kering = 3 langkah, Satuan = 3 langkah).

- [ ] **H-23: Fitur Operasional (Settings & End of Day)**
  - [ ] Settings: Buat halaman **Atur QRIS** (Fungsi *upload* foto QRIS statis ke Supabase Storage dan menampilkannya di aplikasi).
  - [ ] Payment Modal: Tampilkan foto QRIS tersebut secara otomatis di `PaymentBottomSheet` jika kasir memilih metode QRIS.
  - [ ] Settings: Buat halaman **Tutup Buku Harian** (Rekapitulasi otomatis total Pemasukan Tunai vs QRIS dan Pengeluaran hari ini).

- [ ] **H-24: Output, Sharing & Hardware (Cetak & Ekspor)**
  - [ ] Integrasi package `print_bluetooth_thermal` untuk mencetak format struk belanja via printer kasir.
  - [ ] Integrasi package `url_launcher` untuk mengirim nota digital pelanggan dan laporan Tutup Buku ke WhatsApp.
  - [ ] Integrasi package `path_provider` untuk fitur *download* Laporan Bulanan (PDF/CSV) ke penyimpanan internal HP.

- [ ] **H-25: UI/UX Polish & Offline Handling**
  - [ ] Database: *Wrap* seluruh operasi Supabase dengan `Try-Catch`.
  - [ ] UI: Tampilkan Red SnackBar "Koneksi Terputus" jika gagal *insert/update*.
  - [ ] UI: Buat *Empty States* (ilustrasi/teks indikator) jika daftar Pesanan atau Transaksi kosong.

- [ ] **H-26 & H-27: UAT (User Acceptance Testing) & Final Build**
  - [ ] Build: Generate APK Release versi stabil terbaru.
  - [ ] Testing: Sesi uji coba langsung (Cetak struk, Tutup Buku, dan scan QRIS) bersama Mas Zamzami di toko.
  - [ ] Bug Fixes: Perbaikan kilat untuk temuan minor.

- [ ] **H-28: Go Live! 🎉**
  - [ ] Database: Deploy dan bersihkan data *testing* menjadi *Production*.
  - [ ] Handover: Serah terima sistem POS Laundry Jennaira secara resmi.
  