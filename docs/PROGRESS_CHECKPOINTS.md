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
- [ ] **H-8: Model & Provider Order**
  - [ ] Update `OrderModel` (tambah field `discount`, `is_paid`, `cust_address`).
- [ ] **H-9: UI List Order**
  - [ ] Slicing UI OrderListScreen (Tab: Aktif / Selesai / Belum Lunas).
- [ ] **H-10: Form Buat Order (UI)**
  - [ ] Slicing Create Order BottomSheet.
  - [ ] Setup input dinamis (Dropdown Satuan, Radio durasi hari).
- [ ] **H-11: Pricing Engine (Logic)**
  - [ ] Tanamkan logika minimum 1.5kg untuk Express.
  - [ ] Tanamkan logika diskon 1kg (Layanan 1 hari > 5kg).
- [ ] **H-12: Order Detail**
  - [ ] Slicing UI Order Detail (Visual stepper status).
- [ ] **H-13: Payment Modal**
  - [ ] Buat UI Payment BottomSheet (Tunai/QRIS, input uang diterima).
  - [ ] Logika update `is_paid` menjadi true.
- [ ] **H-14: Testing W2**
  - [ ] Test end-to-end pembuatan order dengan algoritma harga.

---

## 🟠 FASE 3: KEUANGAN & DASHBOARD ADMIN (Minggu 3 / H-15 s.d H-21)
*Fokus: Fitur eksklusif Owner untuk memantau arus kas.*
- [ ] **H-15: Transaksi Harian**
  - [ ] UI & Logic List Transaksi (Pemasukan/Pengeluaran).
- [ ] **H-16: Tambah Pengeluaran**
  - [ ] UI & Logic Add Transaksi BottomSheet.
- [ ] **H-17 & H-18: Dashboard Analytics**
  - [ ] Provider hitung omzet & profit hari ini.
  - [ ] Slicing UI Dashboard (Hero cards & Bar Chart).
- [ ] **H-19 & H-20: Laporan & Settings**
  - [ ] UI Laporan Bulanan & Export.
  - [ ] Slicing UI Settings & Inventory stok dasar.
- [ ] **H-21: Testing W3**
  - [ ] Pastikan Kasir sama sekali tidak bisa mengakses halaman W3.

---

## 🟣 FASE 4: POLISHING, OFFLINE & RELEASE (Minggu 4 / H-22 s.d H-28)
*Fokus: Error handling, fitur pendukung, dan serah terima ke klien.*
- [ ] **H-22: Offline Handling**
  - [ ] Wrap semua Supabase queries dengan Try-Catch.
  - [ ] Tampilkan Red SnackBar "Koneksi Terputus" jika gagal `insert/update`.
- [ ] **H-23: WhatsApp Receipt**
  - [ ] Integrasi `url_launcher`.
  - [ ] Buat format teks nota digital untuk dikirim ke WA.
- [ ] **H-24 & H-25: UI/UX Polish**
  - [ ] Empty states untuk list kosong.
  - [ ] Loading indicators & validasi form.
- [ ] **H-26 & H-27: UAT (User Acceptance Testing)**
  - [ ] Build APK Release.
  - [ ] Sesi testing langsung bersama Mas Zamzami di toko.
  - [ ] Fix bug minor temuan UAT.
- [ ] **H-28: Go Live! 🎉**
  - [ ] Deploy database production.
  - [ ] Serah terima ke Mas Zamzami.