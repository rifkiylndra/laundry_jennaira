# DESIGN SYSTEM & UI/UX SPECIFICATIONS: LAUNDRY JENNAIRA V3.0
**Target Platform:** Mobile App (Android & iOS) - Flutter
**Target Role:** Admin (Owner) & Cashier
**Design Language:** Material Design 3

## 1. COLOR PALETTE
Strictly adhere to these Hex codes for all UI components.
- **Primary Brand:** `#0F2D5E` (Deep Navy Blue) - Used for AppBars, primary buttons, headers.
- **Accent:** `#2563EB` (Royal Blue) - Used for active tabs, links, active radio buttons.
- **Background:** `#F8FAFC` (Slate 50) - Base background for all screens.
- **Cards/Surfaces:** `#FFFFFF` (White) - Must have a soft, subtle drop shadow.
- **Text Primary:** `#374151` (Gray 700) - For standard reading text.
- **Text Secondary:** `#64748B` (Gray 500) - For hints, subtitles, dates.
- **Success/Income:** `#166534` (Dark Green) - For income numbers, positive profit, "Selesai" status chip, "Lunas" badge.
- **Warning (Pending/Process):** `#9A3412` (Dark Orange) - For "Siap Diambil" status chip, warning banner.
- **Danger/Expense/Offline:** `#B91C1C` (Red) - For expense numbers, negative profit, critical stock alerts, offline banner/snackbar.

## 2. TYPOGRAPHY & SPACING
- **Font Family:** Standard sans-serif (Inter or Roboto).
- **Corner Radius:** 12px or 16px for all Cards, Buttons, and BottomSheets to create a modern, friendly look.
- **Padding:** Generous padding (minimum 16px to 24px) on screen edges.
- **Animations:** Keep transitions minimal (e.g., standard FadeTransition). When designing loading states, success states, or empty states, **do not animate photos or images; only animate text and other non-photo UI elements.**

## 3. GLOBAL COMPONENTS
- **Offline Banner:** A `MaterialBanner` or `SnackBar` with Background `#B91C1C` and White text: "Koneksi Terputus. Data gagal disimpan." Must appear at the top/bottom if internet drops.

---

## 4. SCREEN SPECIFICATIONS

### 4.0 Splash / Loading Screen
- **Background:** Full Primary Color (`#0F2D5E`).
- **Content:** Centered text "Laundry Jennaira" (White, Bold, Large, Outfit/Inter).
- **Bottom:** White circular progress indicator.

### 4.1 Login Screen
- **Content:** Minimalist. Logo/App Name, "Email" field, "Password" field.
- **Action:** Full-width Primary Button "Login".

### 4.2 Dashboard Screen (ADMIN ONLY)
*Cashiers cannot access this screen.*
- **Top:** AppBar with "Laundry Jennaira" and a Settings gear icon.
- **Hero:** 3 horizontal summary cards (Saldo, Omzet, Profit). Profit text color depends on positive/negative value.
- **Middle:** Bar chart (7 days income).
- **Bottom:** Grid of 4 quick action buttons (Kiloan, Satuan, Setrika, Express).
- **Navigation:** BottomNavBar (Home, Order, Transaksi, Laporan).

### 4.3 Order List Screen (ADMIN & CASHIER)
*For Cashier, this is their home screen. Do not show Admin tabs in their BottomNavBar.*
- **Top:** Search bar (by Name/Order No).
- **Tabs:** Horizontal TabBar (Aktif | Selesai | Belum Lunas).
- **List:** Order Cards. Each card shows: Order ID, Cust Name, Service + Weight, and a Color-coded Status Chip.
- **Action:** Floating Action Button (FAB) with a '+' icon.

### 4.4 Create Order (Full-Screen Bottom Sheet)
*Due to additional fields, this should be a tall BottomSheet or a Full Dialog.*
- **Customer Info:** Fields for Name, Phone, and **Address** (TextFields).
- **Service Selection:** ChoiceChips for (Cuci Gosok, Cuci Kering, Satuan, Express).
- **Dynamic Inputs (Based on Service):**
  - *If Cuci Gosok/Kering:* Show Radio buttons for Duration (1 Hari, 2 Hari, 3 Hari) and a numeric input for Weight (kg).
  - *If Express:* Show numeric input for Weight (kg) with hint text "Min. 1.5 kg".
  - *If Satuan:* Show Dropdown for Item Type (Sprei, Karpet, etc.) OR a manual price input field.
- **Bottom Fixed Area:** Large text for "Total Estimasi" and a Primary Button "Simpan Pesanan".

### 4.5 Order Detail Screen
- **Header:** Order No, Date, Status Stepper (Diterima -> Dicuci -> Siap Diambil -> Selesai).
- **Customer Card:** Name, Phone, Address.
- **Actions Row:**
  - Outline Button: "Kirim Nota via WA" (Green icon).
  - Primary Button: "Update Status" (Button color changes according to next status).
- **Payment Section:**
  - If `is_paid` is false AND status is 'Siap Diambil' or 'Selesai' -> Show a prominent "Bayar Lunas" button.
  - If `is_paid` is true -> Show a green checkmark "Lunas".

### 4.6 Payment Modal (NEW - Triggered from Order Detail)
- **Type:** Modal Bottom Sheet.
- **Header:** Title "Pembayaran Order" and Order No.
- **Highlight:** Huge typography displaying the Final Total (e.g., "Rp 35.000").
- **Inputs:**
  - Segmented Control / Radio for "Tunai" vs "QRIS".
  - Numeric input field "Uang Diterima" (for Cash payment to calculate change).
  - Dynamic text showing "Kembalian: Rp X.XXX".
- **Action:** Full-width Primary Button "Konfirmasi Pembayaran".

### 4.7 Transaksi & Tambah Transaksi (ADMIN ONLY)
- **List:** Filter tabs (Pemasukan, Pengeluaran). List items grouped by Date. Green text for income, Red for expense.
- **Add (BottomSheet):** Toggle (Pemasukan/Pengeluaran). Category grid. Large numeric input for amount. Notes field. Button "Simpan".

### 4.8 Laporan Screen (ADMIN ONLY)
- **Top:** TabBar (Harian | Bulanan) and Date Picker.
- **Content:** Summary Cards (Total Income, Expense, Profit) and Data visualization (Charts).

### 4.9 Settings & Inventory (ADMIN ONLY)
- **Settings List:** Edit Tarif, Info Usaha, QRIS, Manajemen Stok, Tutup Buku, Logout.
- **Inventory Screen:** List of items (Deterjen, Plastik) with progress bars. Red warning for low stock. '+' and '-' buttons to adjust.