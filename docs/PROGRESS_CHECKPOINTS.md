# 🚀 PROGRESS CHECKPOINT: LAUNDRY JENNAIRA MVP
**Durasi:** 3 Minggu (21 Hari Kerja)
**Target Rilis:** [Isi Tanggal Rilis]
**Developer:** Rifki Yuliandra

---

## 🟢 FASE 0: PRE-SPRINT (Setup & Fondasi)
*Target: Selesai sebelum coding hari pertama dimulai.*
- [x] [cite_start]Buat project Supabase (Free tier, region Singapore)[cite: 204].
- [x] [cite_start]Jalankan semua DDL SQL di Supabase SQL Editor[cite: 205].
- [x] [cite_start]Seed data: categories (13 default) + settings (tarif dari klien)[cite: 206].
- [x] [cite_start]Aktifkan RLS semua tabel + buat policy untuk user `authenticated`[cite: 207].
- [x] [cite_start]Buat project Flutter: `flutter create laundry_jennaira`[cite: 202].
- [x] [cite_start]Tambah semua dependencies di `pubspec.yaml` (supabase_flutter, riverpod, go_router, dll)[cite: 203].
- [x] [cite_start]Setup struktur folder `lib/` sesuai arsitektur [cite: 126-170].
- [ ] [cite_start]Setup GitHub repo + branching strategy (main/dev)[cite: 194].

---

## 🔵 FASE 1: CORE ENGINE & ORDER (Minggu 1 / H-1 s.d H-7)
*Fokus: Autentikasi dan alur pesanan laundry dari awal sampai selesai.*
- [ ] **H-1 & H-2: Auth & Navigasi**
  - [x] [cite_start]Inisialisasi Supabase di `main.dart` dengan URL + anon key[cite: 208].
  - [x] [cite_start]Setup GoRouter dengan 4 tab bottom nav[cite: 210].
  - [x] [cite_start]Buat `theme.dart` (Warna utama `#0F2D5E` dll)[cite: 211, 265].
  - [ ] [cite_start]Login screen (email+password via Supabase Auth)[cite: 194].
  - [x] [cite_start]Utility: `formatRupiah()`, `formatDate()`, `generateOrderNo()`[cite: 212].
- [ ] **H-3: Model & Provider Order**
  - [ ] [cite_start]Buat `OrderModel` (fromJson, toJson, enum status)[cite: 214].
  - [ ] [cite_start]Buat `OrderProvider` (stream data realtime)[cite: 215].
- [ ] **H-4: UI List Order**
  - [ ] [cite_start]Buat `OrderListScreen` dengan 3 Tab: Semua/Aktif/Selesai[cite: 218].
  - [ ] [cite_start]Buat `OrderCard` dengan chip status berwarna[cite: 219].
- [ ] **H-5: Buat & Detail Order**
  - [ ] [cite_start]Buat `CreateOrderBottomSheet` (validasi + hitung harga otomatis)[cite: 220].
  - [ ] [cite_start]Buat `OrderDetailScreen` dengan visual stepper status[cite: 221].
- [ ] **H-6: Status & Payment Flow**
  - [ ] [cite_start]Logika update status order[cite: 217].
  - [ ] [cite_start]Dialog payment saat order 'Selesai' -> auto-insert transaksi income[cite: 222].
- [ ] **H-7: Testing W1**
  - [ ] [cite_start]Test end-to-end alur order, fix bug minor[cite: 194].

---

## 🟡 FASE 2: KEUANGAN & DASHBOARD (Minggu 2 / H-8 s.d H-14)
*Fokus: Pencatatan cashflow dan visualisasi data realtime.*
- [ ] **H-8: Model & Provider Transaksi**
  - [ ] [cite_start]Buat `TransactionModel` & `CategoryModel`[cite: 225].
  - [ ] [cite_start]Buat `TransactionProvider` (CRUD + stream)[cite: 226].
- [ ] **H-9: UI List Transaksi**
  - [ ] [cite_start]Buat `TransactionListScreen` (grouped by date)[cite: 229].
  - [ ] [cite_start]Filter chips & swipe to delete[cite: 196, 233].
- [ ] **H-10: Form Transaksi**
  - [ ] [cite_start]Buat `AddTransactionBottomSheet` (toggle IN/OUT, grid kategori)[cite: 230, 231].
  - [ ] [cite_start]Integrasi upload foto bukti ke Supabase Storage[cite: 232].
- [ ] **H-11: Data Dashboard**
  - [ ] [cite_start]Buat `DashboardProvider` (hitung omzet hari & bulan, profit)[cite: 235].
  - [ ] [cite_start]Setup realtime subscription untuk dashboard[cite: 236].
- [ ] **H-12: UI Dashboard**
  - [ ] [cite_start]Bangun `DashboardScreen` (Hero cards, 4 quick add buttons)[cite: 237, 239].
  - [ ] [cite_start]Implementasi BarChart 7 hari pakai `fl_chart`[cite: 238].
  - [ ] [cite_start]Tampilkan banner peringatan order "Siap Diambil"[cite: 240].
- [ ] **H-13: Laporan Dasar**
  - [ ] [cite_start]Buat `ReportScreen` (Tab Harian & Bulanan) + DatePicker[cite: 243, 244].
- [ ] **H-14: Testing W2**
  - [ ] [cite_start]Uji sinkronisasi omzet dashboard setelah input transaksi[cite: 196].

---

## 🟣 FASE 3: POLISHING & HANDOVER (Minggu 3 / H-15 s.d H-21)
*Fokus: Fitur pendukung, merapikan UI, dan persiapan rilis.*
- [ ] **H-15: Export PDF**
  - [ ] [cite_start]Buat `PdfGenerator` untuk laporan bulanan[cite: 248].
  - [ ] [cite_start]Implementasi tombol share via WhatsApp (`share_plus`)[cite: 249].
- [ ] **H-16: Tutup Buku & Stok**
  - [ ] [cite_start]Buat dialog `DailyClosingDialog` (hitung selisih kas fisik)[cite: 251].
  - [ ] [cite_start]Buat `InventoryScreen` (CRUD stok dasar)[cite: 252].
- [ ] **H-17: Pengaturan & QRIS**
  - [ ] [cite_start]Buat `SettingsScreen` (Edit tarif & info usaha)[cite: 253].
  - [ ] [cite_start]Generate QR statis dari string QRIS BCA (`qr_flutter`)[cite: 254].
- [ ] **H-18: UI/UX Polish**
  - [ ] [cite_start]Tambahkan loading shimmer / overlay[cite: 256].
  - [ ] [cite_start]Tambahkan empty state untuk list yang kosong[cite: 257].
  - [ ] [cite_start]Rapikan error handling[cite: 258].
- [ ] **H-19 & H-20: UAT & Bug Fix**
  - [ ] [cite_start]Build APK Release dan test di HP Zamzami[cite: 198].
  - [ ] [cite_start]Catat dan perbaiki semua bug prioritas tinggi[cite: 198].
- [ ] **H-21: Serah Terima! 🎉**
  - [ ] [cite_start]Deploy akun production di Supabase[cite: 198].
  - [ ] [cite_start]Serah terima final & berikan tutorial ke Mas Zamzami[cite: 198].