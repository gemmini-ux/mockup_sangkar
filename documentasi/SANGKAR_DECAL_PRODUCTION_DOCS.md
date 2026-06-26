# SANGKAR DECAL PRODUCTION — DOKUMENTASI PROYEK LENGKAP
> **Versi**: 1.0.0 · **Platform**: Flutter (Web / Desktop / Android) · **Tanggal**: Juni 2026
> **Status Proyek**: 🟢 Berjalan — Mockup 01 aktif, Mockup 02–10 dalam antrean

---

## RINGKASAN EKSEKUTIF

Aplikasi **Sangkar Decal Production** adalah sistem manajemen produksi **decal (stiker dekoratif)** untuk sangkar burung.  
Fokus aplikasi: pencetakan, pemotongan, QC, dan pengiriman decal bergambar motif nusantara (batik, ukiran, ornamen) yang ditempelkan pada sangkar burung premium (Murai Batu, Lovebird, Kacer, Kenari, dll.).

**Konsep Utama — "1 App, 10 Mockup":**
Satu aplikasi Flutter berisi **10 tema UI/UX berbeda** yang dapat dipilih dari layar beranda (launcher).
Setiap mockup memiliki layout, skema warna, dan pendekatan UX unik — namun berbagi logika bisnis dan data dummy yang sama.

---

## 1. ARSITEKTUR PROYEK (KONDISI AKTUAL)

### 1.1 Struktur Folder As-Built
```
mocupsangkar/
 ├── lib/
 │    ├── main.dart                          # Entry point — GetMaterialApp
 │    ├── homepage.dart                      # Launcher: grid 4 kolom, 10 card mockup
 │    ├── providers/
 │    │    ├── theme_provider.dart           # [Placeholder] global theme
 │    │    └── layout_provider.dart          # [Placeholder] layout state
 │    └── features/
 │         ├── mockup01/                     # ✅ AKTIF — Cyber Dark Blue
 │         │    ├── homepage_mc01.dart       # Shell (Sidebar + Topbar + ScrollContent)
 │         │    ├── sidebar.dart             # Sidebar 280px, 14 menu item
 │         │    ├── stat_card.dart           # StatCard + SparklinePainter
 │         │    └── halaman dashboard/
 │         │         ├── dashboard.dart      # Header "DASHBOARD" + tanggal widget
 │         │         ├── topbar.dart         # SearchBar + Status + User + Icons
 │         │         ├── project_panel.dart  # Antrean Produksi — ListView + badge
 │         │         ├── activity_panel.dart # Log Aktivitas Terbaru
 │         │         ├── schedule_panel.dart # Jadwal Hari Ini
 │         │         ├── analytics_card.dart # Line Chart Analitik (fl_chart)
 │         │         ├── donut_chart_card.dart # Donut Chart Statistik (fl_chart)
 │         │         ├── production_card.dart  # KPI Produksi Harian + progress bar
 │         │         ├── quick_access_card.dart # Grid 8 shortcut akses cepat
 │         │         └── notification_card.dart # Panel notifikasi sistem
 │         ├── mockup02/ … mockup10/        # 🔲 Belum dibuat
 │         ├── design/
 │         │    └── views/design_editor.dart # [Placeholder]
 │         ├── layout_studio/views/          # [Placeholder]
 │         └── template/views/              # [Placeholder]
 ├── documentasi/
 │    ├── SANGKAR01_MASTER_IMPLEMENTATION_PLAN.md
 │    └── SANGKAR_DECAL_PRODUCTION_DOCS.md   ← dokumen ini
 ├── pubspec.yaml
 └── web/index.html
```

### 1.2 Dependencies Aktual (pubspec.yaml)
| Package | Versi | Fungsi |
|---------|-------|--------|
| `flutter` SDK | — | Core framework |
| `get` | ^4.6.6 | Navigation & state (GetX) |
| `provider` | ^6.1.2 | State provider (planned) |
| `google_fonts` | ^6.2.1 | Tipografi premium |
| `fl_chart` | ^0.68.0 | Donut & line chart |
| `flutter_animate` | ^4.5.0 | Micro-animasi & transisi |
| `hive` + `hive_flutter` | ^2.2.3 | Local storage (planned) |
| `model_viewer_plus` | ^1.9.1 | Preview 3D model (planned) |
| `cupertino_icons` | ^1.0.8 | Icon set |

---

## 2. KONTEKS BISNIS — PRODUKSI DECAL SANGKAR

### 2.1 Definisi Produk
**Decal Sangkar** = stiker vinil/polimer dekoratif bergambar motif nusantara (batik parang, kawung, mega mendung, ornamen ukiran) yang ditempelkan pada permukaan sangkar burung.

### 2.2 Alur Produksi
```
[PESANAN MASUK]
      ↓
[DESAIN DECAL] — Upload/edit motif SVG/PNG
      ↓
[CETAK / Printing] — Mesin print vinyl
      ↓
[POTONG / Cutting] — Mesin cutting plotter
      ↓
[QUALITY CONTROL] — Cek kualitas cetak & potongan
      ↓
[PACKING] — Kemas per unit, label pengiriman
      ↓
[PENGIRIMAN] — Ekspedisi ke pelanggan
      ↓
[SELESAI ✓]
```

### 2.3 Status Produksi (Implementasi Aktual)
| Status | Warna Badge | Keterangan |
|--------|-------------|------------|
| `Desain` | 🟣 Purple | File decal sedang dibuat / direvisi |
| `Printing` | 🔵 Blue | Sedang di mesin cetak |
| `Cutting` | 🟠 Orange | Proses pemotongan vinyl |
| `QC` | 🟢 Green | Pengecekan kualitas hasil cetak+potong |
| `Packing` | 🩵 Cyan | Pengemasan produk |

---

## 3. PLANNING — ROADMAP 10 MOCKUP

### 3.1 Konsep Launcher
`homepage.dart` menampilkan **GridView 4 kolom** dengan 10 card.
Setiap card berisi ikon `dashboard_customize_rounded`, nama mockup, dan subtitle "Layout N".
Tap card → `Get.to(() => pages[index], transition: Transition.fadeIn)`.

```
HomePage (Launcher Grid)
 ├── [✅] Mockup Sangkar 01 — Cyber Dark Blue
 ├── [🔲] Mockup Sangkar 02 — Neon Purple
 ├── [🔲] Mockup Sangkar 03 — Clean Minimalist
 ├── [🔲] Mockup Sangkar 04 — Retro Amber
 ├── [🔲] Mockup Sangkar 05 — Oceanic Teal
 ├── [🔲] Mockup Sangkar 06 — Forest Green
 ├── [🔲] Mockup Sangkar 07 — Metallic Crimson
 ├── [🔲] Mockup Sangkar 08 — Sakura Pink
 ├── [🔲] Mockup Sangkar 09 — Cyberpunk Yellow
 └── [🔲] Mockup Sangkar 10 — Monochrome Glass
```

### 3.2 Tabel 10 Mockup
| # | Nama | Background | Accent | Navigasi | Layout Khas | Animasi |
|---|------|-----------|--------|----------|-------------|---------|
| 01 | Cyber Dark Blue | `#030712` | Cyan | Sidebar kiri 280px | Multi-row grid panel | Sparkline draw |
| 02 | Neon Purple | `#0A0014` | Purple glow | Sidebar collapsible | Cards floating | Glow pulse |
| 03 | Clean Minimalist | `#F8F9FA` | Emerald | Top navigation bar | Flat card list | Slide-in |
| 04 | Retro Amber | `#1A1000` | Amber | Sidebar kanan | Vintage grid | Fade + sepia |
| 05 | Oceanic Teal | `#001A1A` | Teal | Bottom tab bar | Card stack | Wave ripple |
| 06 | Forest Green | `#0A1A0A` | Emerald | Rail navigation | Split view | Organic grow |
| 07 | Metallic Crimson | `#1A0000` | Red | Sidebar + header | Grid metallic | Shimmer |
| 08 | Sakura Pink | `#1A0A0F` | Rose | Floating FAB menu | Masonry layout | Bloom fade |
| 09 | Cyberpunk Yellow | `#0A0A00` | Yellow | Diagonal sidebar | Offset grid | Glitch flash |
| 10 | Monochrome Glass | `#101010` | White | Glass overlay nav | Full backdrop-blur | Frosted reveal |

---

## 4. FRONTEND DOCUMENTATION — MOCKUP 01 (AKTIF)

### 4.1 Design Token Mockup 01
```dart
// Color palette (aktual dari kode)
backgroundColor : Color(0xFF030712)   // Layar utama
surfaceCard     : Color(0xFF091121)   // Background semua card
sidebarBg       : Color(0xFF07101F)   // Sidebar
sidebarBorder   : Color(0xFF16253C)   // Border kanan sidebar
topbarBg        : Color(0xFF0B1424)   // Topbar

// Accent
primaryAccent   : Colors.cyanAccent           // Highlight, icon aktif
borderCyan      : Colors.cyan @ alpha 0.15–0.25
glowCyan        : Colors.cyan @ alpha 0.08    // BoxShadow glow
```

### 4.2 Layout Shell Mockup 01
```
HomePageMc01 (Scaffold, bg: #030712)
 └── Row
      ├── Sidebar (width: 280px)           [sidebar.dart]
      │    ├── Logo card: SANGKAR Designer Studio
      │    ├── ListView 14 menu item
      │    │    Dashboard ← (index 0, aktif/cyan)
      │    │    Template, Desain, Tema & Style, Ornamen,
      │    │    Komponen, AI Prompt, Mapping Editor,
      │    │    Preview 3D, Produksi, Pesanan,
      │    │    Pelanggan, Laporan, Pengaturan
      │    └── User card: Admin Produksi / Professional
      │
      └── Expanded → Column
           ├── Topbar (h:82px, margin:24/20/24/10) [topbar.dart]
           │    ├── SearchField + badge "CTRL + K"
           │    ├── Tanggal (24 Juli 2025, Kamis)
           │    ├── Status: "Database Online" 🟢
           │    ├── Icons: Notifikasi | Mail | Dark Mode
           │    └── Avatar + "Admin Produksi / Administrator"
           │
           └── SingleChildScrollView (padding: 20)
                └── Column
                     ├── DashboardCard          [dashboard.dart]
                     │    "DASHBOARD" + greeting + date chip
                     │
                     ├── Wrap(StatCard × 5, spacing:16)
                     │    Total Desain 128 | Selesai 86
                     │    Dalam Proses 24 | Revisi 18 | Arsip 12
                     │
                     ├── Row 1 (crossAxis: start)
                     │    ├── ProjectPanel   flex:3  [project_panel.dart]
                     │    ├── ActivityPanel  flex:2  [activity_panel.dart]
                     │    └── SchedulePanel  flex:2  [schedule_panel.dart]
                     │
                     ├── Row 2
                     │    ├── DonutChartCard flex:1  [donut_chart_card.dart]
                     │    ├── AnalyticsCard  flex:2  [analytics_card.dart]
                     │    └── ProductionCard flex:1  [production_card.dart]
                     │
                     └── Row 3
                          ├── QuickAccessCard flex:2  [quick_access_card.dart]
                          └── NotificationCard flex:1 [notification_card.dart]
```

### 4.3 Deskripsi Widget Per File

#### `stat_card.dart` — StatCard
- **Props**: `title String`, `value String`, `color Color`, `icon IconData`
- **Fitur**: Icon box bertema warna, nilai besar, label "18% vs bulan lalu", CustomPaint sparkline
- **5 instance**: Total Desain (purple), Selesai (green), Dalam Proses (orange), Revisi (cyan), Arsip (blue)

#### `sidebar.dart` — Sidebar
- **Width**: 280px · **Bg**: `#07101F` · **Border-right**: `#16253C`
- **Logo**: CircleAvatar(cyanAccent) + "SANGKAR / Designer Studio"
- **14 Menu Items** dengan status aktif index 0 (cyan highlight)
- **User footer**: CircleAvatar + "Admin Produksi / Professional Edition"

#### `topbar.dart` — Topbar
- **Height**: 82px · **Radius**: 20 · **Border**: cyan @ 0.15
- **Search**: TextField + badge "CTRL + K" (right side)
- **Status chip**: "Database Online" badge green
- **Action icons**: Notifikasi | Mail | Dark Mode (static, belum fungsional)

#### `project_panel.dart` — Antrean Produksi
- Label: **"ANTRIAN PRODUKSI"** + link "Lihat Semua"
- **5 Data Dummy**:
  ```
  SGK-001 · Murai Borneo Premium  · Printing · 25 qty
  SGK-002 · Lovebird Elegan       · Cutting  · 18 qty
  SGK-003 · Kacer Hexagon         · QC       · 12 qty
  SGK-004 · Kenari Minimalis      · Packing  · 30 qty
  SGK-005 · Anis Merah Luxury     · Desain   · 15 qty
  ```

#### `production_card.dart` — Status Produksi
- **Target**: 120 unit · **Tercapai**: 94 unit (78%)
- **LinearProgressIndicator**: value 0.78, cyan
- **Sub-metrics**: QC 8 | Packing 6 | Belum 26
- **CTA**: FilledButton "Lihat Produksi"

#### `quick_access_card.dart` — Akses Cepat
- **8 shortcut** dalam Wrap grid 145×120px:
  Pesanan (cyan) | Produksi (purple) | Stok (orange) | Decal (green)
  Model (pink) | QC (amber) | Pengiriman (blue) | Pelanggan (red)

---

## 5. BACKEND / DATA LAYER — DUMMY DATA

### 5.1 Strategi Data (Prototype)
Semua data bersifat **inline hardcode** dalam widget — tidak ada API call nyata.
Ini adalah strategi yang tepat untuk **prototype mockup** karena:
- Tidak perlu server → langsung bisa dijalankan di mana saja
- Data realistis sesuai konteks bisnis produksi decal
- Mudah dimodifikasi untuk demo

### 5.2 Master Dummy Data Per Modul

#### Modul Produksi — Antrean
```dart
final List<Map<String, String>> orders = [
  {"kode": "SGK-001", "nama": "Murai Borneo Premium",  "status": "Printing", "qty": "25"},
  {"kode": "SGK-002", "nama": "Lovebird Elegan",       "status": "Cutting",  "qty": "18"},
  {"kode": "SGK-003", "nama": "Kacer Hexagon",         "status": "QC",       "qty": "12"},
  {"kode": "SGK-004", "nama": "Kenari Minimalis",      "status": "Packing",  "qty": "30"},
  {"kode": "SGK-005", "nama": "Anis Merah Luxury",     "status": "Desain",   "qty": "15"},
];
```

#### Modul Statistik KPI
```dart
// Total: 128 | Selesai: 86 | Dalam Proses: 24 | Revisi: 18 | Arsip: 12
// Tren semua: +18% vs bulan lalu
```

#### Modul Produksi Harian
```dart
const int targetUnit = 120;
const int selesaiUnit = 94;
const double progress = 0.78;   // 78%
const int qcUnit = 8;
const int packingUnit = 6;
const int belumUnit = 26;
```

#### Modul Akses Cepat (8 menu)
```dart
// Pesanan | Produksi | Stok | Decal | Model | QC | Pengiriman | Pelanggan
```

### 5.3 Data Dummy Rencana (Modul CRUD Berikutnya)

#### Orders (Pesanan Decal)
```json
[
  {"id": "ORD-001", "pelanggan": "Budi Santoso",  "motif": "Batik Parang",    "qty": 25, "deadline": "2026-07-05", "status": "Printing"},
  {"id": "ORD-002", "pelanggan": "Siti Rahayu",   "motif": "Mega Mendung",    "qty": 18, "deadline": "2026-07-08", "status": "Cutting"},
  {"id": "ORD-003", "pelanggan": "Ahmad Fauzi",   "motif": "Kawung Klasik",   "qty": 12, "deadline": "2026-07-10", "status": "QC"},
  {"id": "ORD-004", "pelanggan": "Rina Kusuma",   "motif": "Truntum Jawa",    "qty": 30, "deadline": "2026-07-12", "status": "Packing"},
  {"id": "ORD-005", "pelanggan": "Dodi Pratama",  "motif": "Garuda Heritage", "qty": 15, "deadline": "2026-07-15", "status": "Desain"}
]
```

#### Designs (Katalog Desain Decal)
```json
[
  {"id": "DSN-001", "nama": "Batik Parang Klasik",    "kategori": "Batik",   "ukuran": "30x20cm", "format": "SVG"},
  {"id": "DSN-002", "nama": "Mega Mendung Premium",   "kategori": "Batik",   "ukuran": "25x15cm", "format": "PNG"},
  {"id": "DSN-003", "nama": "Kawung Minimalis",       "kategori": "Batik",   "ukuran": "20x20cm", "format": "SVG"},
  {"id": "DSN-004", "nama": "Garuda Nusantara",       "kategori": "Ornamen", "ukuran": "40x30cm", "format": "PNG"},
  {"id": "DSN-005", "nama": "Bunga Lotus Carving",    "kategori": "Ukiran",  "ukuran": "35x25cm", "format": "SVG"}
]
```

#### Inventory (Stok Material)
```json
[
  {"id": "INV-001", "nama": "Vinyl Putih A4",       "satuan": "lembar", "stok": 500, "minimum": 100},
  {"id": "INV-002", "nama": "Vinyl Transparan A4",  "satuan": "lembar", "stok":  85, "minimum": 100},
  {"id": "INV-003", "nama": "Tinta Pigmen Cyan",    "satuan": "ml",     "stok": 250, "minimum":  50},
  {"id": "INV-004", "nama": "Tinta Pigmen Magenta", "satuan": "ml",     "stok":  30, "minimum":  50},
  {"id": "INV-005", "nama": "Laminating Glossy",    "satuan": "roll",   "stok":  12, "minimum":   5}
]
```

#### Customers (Pelanggan)
```json
[
  {"id": "CST-001", "nama": "Budi Santoso",  "kota": "Jakarta",   "totalOrder": 12, "totalBeli": "Rp 3.450.000"},
  {"id": "CST-002", "nama": "Siti Rahayu",   "kota": "Bandung",   "totalOrder":  8, "totalBeli": "Rp 2.100.000"},
  {"id": "CST-003", "nama": "Ahmad Fauzi",   "kota": "Surabaya",  "totalOrder": 15, "totalBeli": "Rp 4.875.000"},
  {"id": "CST-004", "nama": "Rina Kusuma",   "kota": "Yogyakarta","totalOrder":  5, "totalBeli": "Rp 1.250.000"},
  {"id": "CST-005", "nama": "Dodi Pratama",  "kota": "Semarang",  "totalOrder":  3, "totalBeli": "Rp 780.000"}
]
```

### 5.4 Rencana API Contract (Future REST)
| Method | Endpoint | Fungsi |
|--------|----------|--------|
| GET | `/api/orders` | List semua pesanan |
| POST | `/api/orders` | Buat pesanan baru |
| PUT | `/api/orders/:id` | Update pesanan |
| DELETE | `/api/orders/:id` | Hapus pesanan |
| GET | `/api/designs` | Katalog desain |
| POST | `/api/designs` | Upload desain baru |
| PUT | `/api/designs/:id` | Edit desain |
| GET | `/api/inventory` | Data stok |
| PUT | `/api/inventory/:id` | Update stok |
| GET | `/api/customers` | Data pelanggan |
| GET | `/api/production/today` | Status produksi harian |

---

## 6. CRUD FLOW PER MODUL

### 6.1 Pesanan Decal
```
CREATE → Form: nama pelanggan, motif decal, qty, ukuran sangkar, deadline
         Validasi → simpan → muncul di list dengan status "Desain"

READ   → List tabel: kode | nama pelanggan | motif | qty | status badge | aksi

UPDATE → Tap baris → form edit → simpan
         atau tap status badge → dropdown ganti status (Desain→Printing→…)

DELETE → Swipe atau tombol hapus → dialog konfirmasi → hapus dari list
```

### 6.2 Desain Decal
```
CREATE → Upload file SVG/PNG → isi nama, kategori, ukuran → simpan ke gallery

READ   → Grid galeri dengan thumbnail, nama, kategori, format file

UPDATE → Tap desain → edit nama/ukuran/kategori → simpan

DELETE → Long-press → "Hapus desain?" → konfirmasi → hilang dari galeri
```

### 6.3 Produksi (Kanban)
```
CREATE → Assign pesanan ke mesin: pilih order, pilih mesin, input operator

READ   → Kanban board 5 kolom: Desain | Printing | Cutting | QC | Packing | Done

UPDATE → Drag card antar kolom atau tap → pilih status baru

DELETE → Batalkan job: konfirmasi → job dihapus, stok dikembalikan
```

### 6.4 Stok Material
```
CREATE → Form tambah item: nama, satuan, stok awal, level minimum

READ   → Tabel: nama | satuan | stok | status level (Cukup/Menipis/Habis)

UPDATE → Input stok masuk: pilih item → tambahkan qty
         Input stok keluar: pilih item → kurangi qty

DELETE → Hapus item stok yang sudah tidak digunakan
```

### 6.5 Pelanggan
```
CREATE → Form: nama, kota/alamat, telepon, email

READ   → List dengan total order & total pembelian per pelanggan

UPDATE → Edit data pelanggan

DELETE → Hapus pelanggan (warning jika masih ada order aktif)
```

---

## 7. UX GUIDELINES

### 7.1 Prinsip Bersama (Semua Mockup)
| Aspek | Implementasi |
|-------|-------------|
| **Warna Status** | Selalu konsisten: Printing=Blue, Cutting=Orange, QC=Green, Packing=Cyan |
| **Animasi Transisi** | `Get.to()` dengan `Transition.fadeIn` 300ms |
| **Responsivitas** | `LayoutBuilder + Wrap` untuk menyesuaikan lebar layar |
| **Glassmorphism** | `BoxDecoration` dengan `color @ opacity + border @ opacity + glow shadow` |
| **Loading State** | `flutter_animate` fade-in saat widget muncul |
| **Micro-animation** | Sparkline custom painter, progress bar animasi |

### 7.2 Navigasi Sidebar Mockup 01 — Rencana Fungsional
```dart
// sidebar.dart — setiap menu item akan navigasi ke halaman yang berbeda
onTap: () {
  switch (index) {
    case 0: Get.to(() => DashboardPage());  break;  // ✅ sudah ada
    case 1: Get.to(() => TemplatePage());   break;  // 🔲 planned
    case 2: Get.to(() => DesainPage());     break;  // 🔲 planned
    case 9: Get.to(() => ProduksiPage());   break;  // 🔲 planned
    case 10: Get.to(() => PesananPage());   break;  // 🔲 planned
    // dst...
  }
}
```

---

## 8. SCREEN INVENTORY

### 8.1 Mockup 01 — Sudah Ada (✅)
| ID | Widget | File | Keterangan |
|----|--------|------|------------|
| M01-001 | HomePage Launcher | `homepage.dart` | Grid 10 card mockup |
| M01-002 | Shell Mc01 | `homepage_mc01.dart` | Sidebar + Topbar + Layout |
| M01-003 | Sidebar | `sidebar.dart` | Nav 14 menu, aktif index 0 |
| M01-004 | Topbar | `topbar.dart` | Search + status + user |
| M01-005 | StatCard ×5 | `stat_card.dart` | KPI + sparkline |
| M01-006 | DashboardCard | `dashboard.dart` | Header + date chip |
| M01-007 | ProjectPanel | `project_panel.dart` | Antrean produksi |
| M01-008 | ActivityPanel | `activity_panel.dart` | Log aktivitas |
| M01-009 | SchedulePanel | `schedule_panel.dart` | Jadwal hari ini |
| M01-010 | DonutChartCard | `donut_chart_card.dart` | Chart statistik |
| M01-011 | AnalyticsCard | `analytics_card.dart` | Line chart analitik |
| M01-012 | ProductionCard | `production_card.dart` | Status produksi harian |
| M01-013 | QuickAccessCard | `quick_access_card.dart` | 8 shortcut menu |
| M01-014 | NotificationCard | `notification_card.dart` | Panel notifikasi |

### 8.2 Screen Direncanakan (🔲 Prioritas)
| Prioritas | Nama Screen | Modul | Target |
|-----------|------------|-------|--------|
| 🔴 P1 | PesananPage — List CRUD | Pesanan | Sprint 2 |
| 🔴 P1 | PesananFormPage — Create/Edit | Pesanan | Sprint 2 |
| 🔴 P1 | ProduksiPage — Kanban Board | Produksi | Sprint 2 |
| 🟡 P2 | DesainPage — Grid Gallery | Desain | Sprint 3 |
| 🟡 P2 | DesainFormPage — Upload | Desain | Sprint 3 |
| 🟡 P2 | StokPage — Inventory Table | Stok | Sprint 3 |
| 🟡 P2 | PelangganPage — CRM List | Pelanggan | Sprint 3 |
| 🟢 P3 | LaporanPage — Analytics | Laporan | Sprint 4 |
| 🟢 P3 | PengaturanPage — Settings | Settings | Sprint 4 |
| ⭐ | Mockup 02–10 (full set) | Multi-mockup | Sprint 4–10 |

---

## 9. SPRINT PLAN

### Sprint 1 ✅ SELESAI
- [x] Entry point GetMaterialApp
- [x] Launcher `homepage.dart` — grid 10 card + routing
- [x] Shell Mockup 01 — Sidebar + Topbar + ScrollView layout
- [x] 14 widget dashboard panel dengan dummy data inline
- [x] StatCard dengan CustomPaint sparkline
- [x] Status badge per warna produksi
- [x] fl_chart donut + line chart

### Sprint 2 🔲 BERIKUTNYA
- [ ] Aktifkan routing sidebar onTap semua 14 menu
- [ ] `PesananPage` — tabel list + filter status + search
- [ ] `PesananFormPage` — form Create/Edit pesanan
- [ ] `ProduksiPage` — kanban board 5 kolom drag-and-drop
- [ ] GetX controller `OrderController` + `ProductionController`
- [ ] Snackbar sukses/error untuk setiap aksi CRUD

### Sprint 3 🔲
- [ ] `DesainPage` — galeri grid desain decal
- [ ] `DesainFormPage` — form upload + metadata
- [ ] `StokPage` — tabel inventory + indikator level stok
- [ ] `PelangganPage` — list CRM + riwayat order
- [ ] `StokFormPage` — input stok masuk/keluar
- [ ] Dialog konfirmasi delete dengan animasi

### Sprint 4 🔲
- [ ] `LaporanPage` — chart produksi + revenue per bulan
- [ ] `PengaturanPage` — pilih tema mockup + info app
- [ ] Migrasi data dummy ke Hive local storage
- [ ] Skeleton loading state dengan `flutter_animate`

### Sprint 5–10 🔲
- [ ] Implementasikan Mockup 02–10 (masing-masing 1 sprint)
- [ ] Setiap mockup: Dashboard + Pesanan CRUD + Produksi board
- [ ] Variasikan layout, warna, navigasi sesuai tabel tema

---

## 10. TASK BREAKDOWN DECAL

### Frontend
| ID | Task | Modul | Status |
|----|------|-------|--------|
| TF-01 | Aktifkan routing sidebar 14 menu | Navigation | 🔲 |
| TF-02 | Buat `PesananPage` tabel CRUD | Pesanan | 🔲 |
| TF-03 | Buat `PesananFormPage` form input | Pesanan | 🔲 |
| TF-04 | Buat `ProduksiPage` kanban board | Produksi | 🔲 |
| TF-05 | Buat `DesainPage` galeri grid | Desain | 🔲 |
| TF-06 | Buat `StokPage` inventory tabel | Stok | 🔲 |
| TF-07 | Buat `PelangganPage` CRM list | Pelanggan | 🔲 |
| TF-08 | GetX controller per modul | State | 🔲 |
| TF-09 | Dialog konfirmasi hapus + snackbar | UX | 🔲 |
| TF-10 | Skeleton loading flutter_animate | UX | 🔲 |
| TF-11 | Filter + search di setiap list page | UX | 🔲 |
| TF-12 | Implementasikan Mockup 02–10 | Multi-theme | 🔲 |

### Backend / Data
| ID | Task | Keterangan | Status |
|----|------|-----------|--------|
| TB-01 | Buat model class `DecalOrder` | Dart class | 🔲 |
| TB-02 | Buat model class `DecalDesign` | Dart class | 🔲 |
| TB-03 | Buat model class `StockItem` | Dart class | 🔲 |
| TB-04 | Buat model class `Customer` | Dart class | 🔲 |
| TB-05 | Setup Hive Box per model | Local DB | 🔲 |
| TB-06 | Seed data dummy ke Hive | Init data | 🔲 |
| TB-07 | Repository layer CRUD per modul | Data layer | 🔲 |

---

## 11. VERIFICATION PLAN

### Checklist Manual Per Mockup
1. **Launcher**: Tap setiap card → mockup yang benar terbuka dengan fadeIn
2. **Responsif**: Resize window → layout LayoutBuilder+Wrap menyesuaikan
3. **Dashboard**: Semua 14 panel tampil dengan data dummy yang benar
4. **CRUD Create**: Form → isi data → simpan → muncul di list
5. **CRUD Read**: List menampilkan semua item dengan badge status benar
6. **CRUD Update**: Edit → simpan → perubahan tersimpan di list
7. **CRUD Delete**: Dialog konfirmasi → hapus → hilang dari list
8. **Status Produksi**: Ubah status → badge & warna berubah sesuai
9. **Back navigation**: Back dari mockup → kembali ke launcher
10. **Sidebar routing**: Setiap menu sidebar → halaman yang benar

### Perintah Jalankan
```bash
# Development mode (web)
flutter run -d chrome

# Development mode (Windows desktop)
flutter run -d windows

# Analisis kode
flutter analyze

# Build release web
flutter build web --release
```

---

## 12. REFERENSI CEPAT

| Resource | Path |
|----------|------|
| Entry point | `lib/main.dart` |
| Launcher | `lib/homepage.dart` |
| Mockup 01 Shell | `lib/features/mockup01/homepage_mc01.dart` |
| Sidebar | `lib/features/mockup01/sidebar.dart` |
| Stat Card | `lib/features/mockup01/stat_card.dart` |
| Dashboard Header | `lib/features/mockup01/halaman dashboard/dashboard.dart` |
| Topbar | `lib/features/mockup01/halaman dashboard/topbar.dart` |
| Antrean Produksi | `lib/features/mockup01/halaman dashboard/project_panel.dart` |
| Status Produksi | `lib/features/mockup01/halaman dashboard/production_card.dart` |
| Akses Cepat | `lib/features/mockup01/halaman dashboard/quick_access_card.dart` |
| Master Plan | `documentasi/SANGKAR01_MASTER_IMPLEMENTATION_PLAN.md` |
| Dependencies | `pubspec.yaml` |

---

*Dokumentasi ini mencerminkan kondisi aktual project. Dibuat berdasarkan analisis kode sumber. Diperbarui: Juni 2026*

