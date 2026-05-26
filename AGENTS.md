# AI AGENT INSTRUCTIONS: LAUNDRY JENNAIRA MVP
**Version:** v3.0 — Revisi Pasca Wawancara Klien (Sprint 4 Minggu - Production Ready)
**Project:** Laundry Jennaira - Aplikasi Manajemen Laundry
**Platform:** Flutter (Android & iOS) + Supabase

## 1. AGENT ROLE & CORE PHILOSOPHY
You are an Expert Senior Flutter & Supabase Developer building an MVP in a strict 4-week timeline.
**Core Philosophy: Ruthless Prioritization.** Do NOT add new features outside of this document. Any new idea must be pushed to the backlog.

### 1.1 In-Scope (Must Do)
- **Role-Based Access Control (RBAC) & Router Redirects:**
  - Support for two roles: `admin` and `cashier` defined in the `profiles` table.
  - Redirects via `go_router` integrated with `authProvider` state:
    - Session null -> `/login`
    - Session active & role == `admin` -> `/dashboard` (Full system access)
    - Session active & role == `cashier` -> `/orders` (Restricted access, hide revenue, settings, analytics)
  - Bottom Navigation bar updates dynamically based on role:
    - Admin: Dashboard, Orders, Transactions, Reports. Settings icon visible in AppBar.
    - Cashier: ONLY shows Orders tab (completely hide other tabs/bottom navigation and use simple Scaffold with FAB). Settings icon hidden in AppBar.
- **Order Management:** Create order (no upfront payment, status initialized to 'diterima'), status transitions (diterima, dicuci, siap_diambil, selesai).
- **Payment & Checkout:** "Bayar Lunas" (Pay) option is only available on the Order Details screen and only when status is 'siap_diambil' or 'selesai'.
- **WhatsApp Receipt:** Receipt generation using `url_launcher` with pre-formatted details (Order No, Name, Service, Total Price, Status).
- **Pricing Engine:** Automatically calculate prices based on rules (Express, Cuci Gosok, Cuci Kering, Satuan).
- **Daily Cash Closing:** Manual daily book closing (Daily closing).
- **Stok Inventory Dasar:** Simple manual stock addition/reduction, low-stock warning highlighting.
- **Offline Resilience & Error Handling:** Wrap all Supabase requests in try-catch. Intercept SocketException / network errors and show a prominent red SnackBar/Banner with: "Koneksi Terputus. Data gagal disimpan."
- **Autentikasi Login:** Supabase Auth with email & password.

### 1.2 Out-of-Scope (Strictly Forbidden for MVP)
- Voice input / speech recognition, Android homescreen widget, OCR foto kwitansi, Manajemen karyawan & absen, Multi-cabang & multi-user (beyond cashier/admin roles), AI insight & goal tracker, CRM pelanggan & loyalty program, Notifikasi WhatsApp otomatis (manual deep-link is allowed, automatic is out-of-scope), Backup Google Drive otomatis, QRIS BCA auto-generate, Piutang & hutang otomatis.

## 2. TECH STACK & DEPENDENCIES
Use the exact stack below. State Management must be Riverpod 2.x using `riverpod_annotation` and code generation. Immutability for models must use `freezed` and `json_serializable`.

```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^2.5.0
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0
  go_router: ^13.0.0
  fl_chart: ^0.68.0
  pdf: ^3.11.0
  printing: ^5.13.0
  qr_flutter: ^4.1.0
  intl: ^0.19.0
  shared_preferences: ^2.2.0
  image_picker: ^1.1.0
  local_auth: ^2.3.0
  uuid: ^4.4.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  url_launcher: ^6.3.0

dev_dependencies:
  build_runner: ^2.4.0
  riverpod_generator: ^2.4.0
  freezed: ^2.4.7
  json_serializable: ^6.8.0
```

## 3. PROJECT STRUCTURE
Follow this exact directory architecture:

```plaintext
lib/
├── main.dart
├── app/
│   ├── router.dart
│   └── theme.dart
├── core/
│   ├── supabase_client.dart
│   ├── constants.dart
│   └── utils/
│       ├── currency.dart
│       ├── date_helper.dart
│       └── order_helper.dart
├── features/
│   ├── auth/ (login_screen.dart, auth_provider.dart, splash_screen.dart)
│   ├── dashboard/ (dashboard_screen.dart, dashboard_provider.dart)
│   ├── order/ (order_list_screen.dart, create_order_sheet.dart, order_detail_screen.dart, order_provider.dart)
│   ├── transaction/ (transaction_list_screen.dart, add_transaction_sheet.dart, transaction_provider.dart)
│   ├── report/ (report_screen.dart, pdf_generator.dart, report_provider.dart)
│   ├── inventory/ (inventory_screen.dart, inventory_provider.dart)
│   └── settings/ (settings_screen.dart)
└── shared/
    ├── widgets/ (summary_card.dart, order_card.dart, loading_overlay.dart)
    └── models/ (profile_model.dart, order_model.dart, transaction_model.dart, category_model.dart)
```

## 4. DATABASE SCHEMA (SUPABASE)
Use UUID for all primary keys. RLS must be enabled for all tables.

```sql
-- Table: profiles
CREATE TABLE profiles (
  id          UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  role        TEXT NOT NULL CHECK (role IN ('admin', 'cashier'))
);

-- Table: orders
CREATE TABLE orders (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_no    TEXT NOT NULL UNIQUE,  
  cust_name   TEXT,
  cust_phone  TEXT,
  cust_address TEXT,
  weight_kg   DECIMAL(5,2) NOT NULL,
  service     TEXT NOT NULL,         
  duration    INT NOT NULL,           -- 1, 2, or 3 days
  status      TEXT DEFAULT 'diterima',
  price       BIGINT NOT NULL,        -- Gross price
  discount    BIGINT DEFAULT 0,       -- Promo discount applied
  is_paid     BOOLEAN DEFAULT false,
  notes       TEXT,
  created_at  TIMESTAMPTZ DEFAULT now(),
  done_at     TIMESTAMPTZ,            -- Estimated completion
  picked_at   TIMESTAMPTZ             -- Actual pickup time
);

-- Table: categories
CREATE TABLE categories (
  id        UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name      TEXT NOT NULL,
  type      TEXT NOT NULL,   
  icon      TEXT,            
  color     TEXT,            
  is_default BOOLEAN DEFAULT false
);

-- Table: transactions
CREATE TABLE transactions (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  type         TEXT NOT NULL,   
  amount       BIGINT NOT NULL, 
  category_id  UUID REFERENCES categories(id),
  order_id     UUID REFERENCES orders(id),  
  note         TEXT,
  photo_url    TEXT,            
  created_at   TIMESTAMPTZ DEFAULT now()
);

-- Table: daily_closing
CREATE TABLE daily_closing (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  date         DATE NOT NULL UNIQUE,
  cash_open    BIGINT DEFAULT 0,
  cash_close   BIGINT DEFAULT 0,  
  total_in     BIGINT DEFAULT 0,  
  total_out    BIGINT DEFAULT 0,
  profit       BIGINT DEFAULT 0,
  selisih      BIGINT DEFAULT 0,  
  note         TEXT,
  created_at   TIMESTAMPTZ DEFAULT now()
);

-- Table: inventory_items & usage
CREATE TABLE inventory_items (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name         TEXT NOT NULL,
  unit         TEXT NOT NULL,   
  stock        DECIMAL(8,2) DEFAULT 0,
  min_stock    DECIMAL(8,2) DEFAULT 1,
  cost_per_unit BIGINT DEFAULT 0
);

CREATE TABLE inventory_usage (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  item_id      UUID REFERENCES inventory_items(id),
  order_id     UUID REFERENCES orders(id),
  amount_used  DECIMAL(8,2) NOT NULL,
  created_at   TIMESTAMPTZ DEFAULT now()
);

-- Table: settings
CREATE TABLE settings (
  key    TEXT PRIMARY KEY,
  value  TEXT NOT NULL
);

-- ENABLE RLS (Apply to all tables)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can access their own profile" ON profiles FOR ALL USING (auth.uid() = id);

ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can access orders" ON orders FOR ALL USING (auth.role() = 'authenticated');
```

## 5. UI/UX DESIGN SYSTEM & COLORS
Strictly use the following hex colors:
- **Primary:** `#0F2D5E` (AppBar, header, tombol utama)
- **Accent / Blue:** `#2563EB` (Button, link, active tab indicator, selected chip)
- **Income / Green:** `#166534` (Angka pemasukan, status Selesai)
- **Expense / Red:** `#991B1B` (Angka pengeluaran, stok kritis, low-stock warning cards)
- **Warning / Orange:** `#9A3412` (Status Siap Diambil, low stock warnings)
- **Background:** `#F8FAFC` (Background semua screen)
- **Card:** `#FFFFFF` (Shadow tipis)

## 6. CRITICAL BUSINESS LOGIC
### 6.1 Pricing Engine
When implementing order creation or checkout calculations, apply the following rules exactly:
- **Express Service (6-8 hours):**
  - Base rate = Rp 12.000 / kg.
  - Weight constraint: `if (weightKg < 1.5) { weightKg = 1.5; }` (Minimum weight constraint).
- **Cuci Gosok:**
  - Rate: 3 Days = Rp 5.000 / kg, 2 Days = Rp 6.000 / kg, 1 Day = Rp 7.000 / kg.
  - Promo Rule: `if (duration == 1 && weightKg > 5) { discount = 7000; } else { discount = 0; }`
- **Cuci Kering:**
  - Rate: 3 Days = Rp 4.000 / kg, 2 Days = Rp 5.000 / kg, 1 Day = Rp 6.000 / kg. No promos.
- **Satuan (Item-based):**
  - Cashier inputs the exact price manually via UI (valid range: Rp 8.000 - Rp 50.000).

### 6.2 Checkout & Payments
- Payment is not required upfront. `is_paid` defaults to `false`.
- "Bayar Lunas" action is only available in Order Details, and only enabled when status is transitioned to 'siap_diambil' or 'selesai'.

### 6.3 WhatsApp Receipt Link
Pre-formatted text receipt deep link:
```text
https://wa.me/{phone}?text={encodedText}
```
Receipt content: Order No, Customer Name, Service, Total Price, Status.

### 6.4 Offline Resilience
- Every Supabase query must run within a try-catch block.
- Capture network exceptions (`SocketException`, `SupabaseClientException`, or general timeouts).
- Update provider state to error state.
- UI displays a prominent red SnackBar or MaterialBanner with: "Koneksi Terputus. Data gagal disimpan."

## 7. SCREEN SPECIFICATIONS & BEHAVIOR
- **Splash Screen:** Entry point. Checks session. If session exists and role is `admin` -> `/dashboard`. If `cashier` -> `/orders`. If null -> `/login`.
- **Login Screen:** Email & Password login, showing loading overlay and error SnackBar/Banner on failure.
- **Dashboard:** Admin-only view. 4 Quick add buttons, hero card (Saldo, omzet, profit), bar chart of last 7 days.
- **Order List:** TabBar (Semua/Aktif/Selesai). Search, pull to refresh. Filtered or laid out for both Admin and Cashier. Cashier layout disables settings access and hides other tabs.
- **Create Order (BottomSheet):** Form for details, weight, service, duration. Automatically updates calculations with transitions.
- **Order Detail:** Stepper for status updates (Diterima -> Dicuci -> Siap Diambil -> Selesai). Button color changes according to next status. "Bayar Lunas" action enabled conditionally. WhatsApp receipt link button.
- **Transaksi List:** Date-grouped. Icon, note, amount (color-coded green/red). Admin only.
- **Add Transaksi (BottomSheet):** Toggle income/expense, preset category grid, numeric amount input, photo upload. Admin only.
- **Laporan:** Daily/monthly stats, chart export PDF option. Admin only.
- **Inventory:** Critical items shown in red if stock < minimum.
- **Settings:** Admin only (Tariff edits, shop info, QRIS, daily closing, stock management, logout). Cashier only has simple logout or settings hidden.

## 8. STRICT DEVELOPMENT RULES FOR THE AI AGENT
1. **No Snippets:** Always output the ENTIRE file content when creating or editing files.
2. **Immutability:** Use `@riverpod` or `@Riverpod(keepAlive: true)` for Riverpod 2.x providers. No Riverpod 1.x styles.
3. **Model Generation:** Use `freezed` and `json_serializable` to define Dart models representing database tables.
4. **Clean Code & Modularity:** Extract complex UI components into private stateless widgets within the same file.
5. **Design Compliance:** Use exact color system hex codes in `theme.dart`.

## 9. DEFINITION OF DONE
- Order creation takes < 30 seconds.
- Cashier accesses only the Orders tab, with settings & reports hidden.
- Network disconnection triggers a red warning banner: "Koneksi Terputus. Data gagal disimpan."
- Receipt text formatting and WhatsApp URL generation are fully functional.
- Zero crashes on common usage paths.