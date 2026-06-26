# SANGKAR DECAL — CERITA DAN DATABASE PANDUAN

---

## 🦜 MENGAPA APLIKASI INI DIBUAT

### Latar Belakang

Bisnis ini bergerak di bidang **produksi decal (stiker dekoratif)** yang ditempelkan pada rangka sangkar burung. Setiap sangkar burung yang dipesan pelanggan perlu dihiasi gambar-gambar motif — mulai dari batik nusantara, ornamen ukiran, hingga gambar tokoh wayang — yang dicetak di atas vinyl lalu dipotong dan ditempelkan oleh tim decal.

Masalahnya: setiap sangkar berbeda-beda.

> *"Sangkar Murai Batu punya bentuk bulat. Sangkar Kacer bisa hexagon. Ukurannya pun berbeda per bagian — kubah, badan atas, badan tengah, kaki — dan setiap bagian punya lebar, tinggi, dan kelengkungan yang berbeda. Tim desainer harus tahu persis ukuran dan bentuk setiap bagian itu sebelum bisa mulai mendesain."*

Tanpa sistem yang tepat, proses ini lambat dan rawan kesalahan:
- Desainer harus bolak-balik tanya ke bagian produksi
- Ukuran salah → decal tidak pas saat ditempelkan → harus cetak ulang
- Tidak ada catatan motif apa yang dipakai untuk pesanan siapa
- Susah memantau pesanan mana yang sudah cetak, masih potong, atau menunggu QC

**Aplikasi ini dibangun untuk menyelesaikan semua itu.**

---

## 🔄 ALUR PROSES PRODUKSI DECAL SANGKAR

### Dari Pesanan Hingga Sangkar Berhias

```
┌─────────────────────────────────────────────────────────────────────┐
│  PELANGGAN memesan sangkar dengan nama & motif decal yang diinginkan │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  ADMIN mencatat pesanan dalam aplikasi:                              │
│  • Nama pelanggan                                                    │
│  • Nama sangkar (misal: "Murai Batu Borneo")                        │
│  • Bentuk sangkar (Bulat, Oval, Hexagon, Kotak)                     │
│  • Bagian yang akan diberi decal (Kubah, Badan Atas, Kaki, dll.)   │
│  • Motif yang diminta (Batik Parang, Kawung, Garuda, dll.)          │
│  • Jumlah unit & deadline                                            │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  TIM DESAINER membuka aplikasi → melihat detail pesanan:             │
│  • Ukuran tiap bagian sangkar sudah tersedia dalam sistem           │
│  • Memilih / membuat desain decal yang sesuai ukuran bagian         │
│  • Menyesuaikan motif dengan bentuk area (silinder, datar, oval)   │
│  • Hasil desain disimpan → siap dikirim ke mesin cetak              │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  MESIN PRINTING mencetak desain ke vinyl:                            │
│  • Epson L1800 / Roland / Mimaki                                    │
│  • Output: lembaran vinyl berisi gambar                              │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  MESIN CUTTING PLOTTER memotong vinyl sesuai bentuk bagian sangkar:  │
│  • Contour cut mengikuti garis desain                               │
│  • Toleransi presisi ±0.5 mm                                        │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  LAMINASI (opsional):                                                │
│  • Lapisan pelindung glossy atau matte di atas decal               │
│  • Mencegah decal pudar dan tahan air                               │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  TIM DECAL menempelkan decal ke bagian-bagian sangkar:               │
│  • Menggunakan squeegee untuk meratakan                             │
│  • Dipandu oleh instruksi dari aplikasi (bagian mana, ukuran apa)  │
│  • Transfer paper membantu penempelan di area lengkung (kubah)     │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  QUALITY CONTROL (QC):                                               │
│  • Cek kualitas cetak (warna, kejernihan)                           │
│  • Cek presisi potongan                                             │
│  • Cek kerapian penempelan (tidak gelembung, sudut rapi)            │
│  • Lulus → lanjut ke Packing | Revisi → kembali ke tahap sebelumnya │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│  PACKING & PENGIRIMAN:                                               │
│  • Sangkar dikemas, dibuatkan label pengiriman                      │
│  • Dikirim via kurir ke pelanggan                                   │
└─────────────────────────────────────────────────────────────────────┘
```

### Peran Aplikasi Dalam Proses

| Tahap | Peran Aplikasi |
|-------|---------------|
| **Pesanan masuk** | Admin input data sangkar + bagian + motif yang dipesan |
| **Desain** | Desainer buka aplikasi → lihat ukuran tiap bagian sangkar → desain decal yang pas |
| **Printing** | Job cetak tertera di antrean produksi, operator konfirmasi mulai & selesai |
| **Cutting** | Jadwal potong muncul di timeline, operator update status |
| **Penempelan** | Tim decal lihat instruksi bagian mana yang ditempel & motifnya |
| **QC** | Inspektor isi checklist QC di aplikasi, hasil otomatis terupdate |
| **Packing & Kirim** | Nomor resi & status pengiriman tercatat |

---

## 📦 BAGIAN-BAGIAN SANGKAR DAN UKURANNYA

Ini adalah data inti yang membuat aplikasi ini unik: **sistem tahu persis ukuran dan bentuk setiap bagian sangkar**, sehingga desainer tidak perlu lagi mengukur manual.

### Contoh: Murai Batu Borneo Premium (Bulat, T 60cm × Ø 45cm)

| Kode Bagian | Nama Bagian | Ukuran Area Decal | Bentuk Area |
|-------------|-------------|-------------------|-------------|
| B-KBH | Kubah | Keliling 141 cm × T 15 cm | Silinder melengkung |
| B-BDA | Badan Atas | Keliling 141 cm × T 10 cm | Silinder |
| B-BDT | Badan Tengah | Keliling 141 cm × T 20 cm | Silinder |
| B-BDB | Badan Bawah | Keliling 141 cm × T 10 cm | Silinder |
| B-KKI | Kaki | 4 sisi × 5 × 5 cm | Datar |
| B-PNT | Pintu | 8 × 12 cm | Datar |

> **Catatan**: Untuk sangkar bulat/silinder, desainer bekerja dalam format **"dibuka datar"** (unrolled) — jadi 1 lingkaran keliling = 1 strip panjang yang dicetak lurus, lalu digulung saat penempelan.

### Contoh: Kacer Hexagon Classic (Hexagon, T 55cm, sisi 20cm)

| Kode Bagian | Nama Bagian | Ukuran Area Decal | Bentuk Area |
|-------------|-------------|-------------------|-------------|
| B-KBH | Kubah Hex | 6 segitiga × 20 × 15 cm | Segitiga datar |
| B-BD1 | Panel Depan | 20 × 25 cm | Datar |
| B-BD2 | Panel Samping A | 20 × 25 cm | Datar |
| B-BD3 | Panel Samping B | 20 × 25 cm | Datar |
| B-BD4 | Panel Belakang | 20 × 25 cm | Datar (tidak perlu decal) |
| B-KKI | Kaki Hex | 6 tiang × 3 × 3 cm | Datar |

---

## 💾 PANDUAN DATABASE DUMMY

### File Database

| File | Path | Keterangan |
|------|------|------------|
| Model classes | `lib/models/sangkar_models.dart` | Definisi semua entitas |
| Dummy data | `lib/data/dummy_db.dart` | Data dummy lengkap |

### Cara Menggunakan di Widget

```dart
// Import di file widget apapun
import 'package:mocupsangkar/data/dummy_db.dart';

// Contoh: Gunakan di ProjectPanel (Antrean Produksi)
final pesanan = DummyDb.pesanan;
// Hasilnya: List<Pesanan> dengan 6 pesanan dummy

// Contoh: Ambil stok yang menipis
final stokKritis = DummyDb.stokMaterial
    .where((s) => s.stokSaat < s.stokMinimum)
    .toList();
// Hasilnya: Vinyl Transparan, Tinta Magenta, Tinta Black

// Contoh: Cari pesanan berdasarkan status
final pesananPrinting = DummyDb.pesanan
    .where((p) => p.statusProduksi == 'Printing')
    .toList();

// Contoh: Ambil bagian sangkar berdasarkan jenis
final jenisMurai = DummyDb.jenisSangkar
    .firstWhere((j) => j.id == 'SK-001');
final bagianDecal = jenisMurai.bagian
    .where((b) => b.perluDecal)
    .toList();
```

### Pemetaan Widget → Data Dummy

| Widget (file) | Data dari DummyDb | Field yang dipakai |
|---------------|-------------------|-------------------|
| `project_panel.dart` | `DummyDb.pesanan` | kode, pelangganNama, statusProduksi, qty |
| `activity_panel.dart` | `DummyDb.aktivitas` | judul, oleh, waktu, tipe |
| `schedule_panel.dart` | `DummyDb.jadwal` | waktu, judul, lokasi, tipe |
| `production_card.dart` | `DummyDb.statistikDashboard` | targetProduksiHarian, realisasiProduksi, dll. |
| `donut_chart_card.dart` | `DummyDb.statistikDashboard` | selesai, dalamProses, revisi |
| `notification_card.dart` | `DummyDb.notifikasi` | judul, subjek, waktu, tipe |
| `stat_card.dart` (×5) | `DummyDb.statistikDashboard` | totalDesain, selesai, dalamProses, revisi, arsip |

### Data Per Menu Sidebar

| Menu Sidebar | Data Utama | Data Pendukung |
|--------------|-----------|----------------|
| **Dashboard** | `statistikDashboard` | `aktivitas`, `jadwal`, `pesanan`, `notifikasi` |
| **Template** | `template` | `jenisSangkar`, `desainDecal` |
| **Desain** | `desainDecal` | `jenisSangkar` |
| **Tema & Style** | — | Token warna per mockup |
| **Ornamen** | `desainDecal` (filter: kategori Ornamen) | — |
| **Komponen** | `jenisSangkar` → `bagian` | — |
| **AI Prompt** | `desainDecal` (input: prompt text) | — |
| **Mapping Editor** | `jenisSangkar`, `bagian` | `desainDecal` |
| **Preview 3D** | `jenisSangkar` | `template` |
| **Produksi** | `jobProduksi`, `jadwal` | `pesanan` |
| **Pesanan** | `pesanan` | `pelanggan`, `jenisSangkar` |
| **Pelanggan** | `pelanggan` | `pesanan` |
| **Laporan** | `statistikDashboard` | `pesanan`, `stokMaterial`, `qcRecords` |
| **Pengaturan** | — | Konfigurasi app |

---

## 📋 DATA DUMMY LENGKAP — RINGKASAN

### Pelanggan (7 record)
| ID | Nama | Kota | Total Pesanan |
|----|------|------|--------------|
| CST-001 | Budi Santoso | Jakarta Timur | 12 |
| CST-002 | Siti Rahayu | Bandung | 8 |
| CST-003 | Ahmad Fauzi | Surabaya | 15 |
| CST-004 | Rina Kusuma | Yogyakarta | 5 |
| CST-005 | Dodi Pratama | Semarang | 3 |
| CST-006 | Heri Purnomo | Malang | 20 |
| CST-007 | Dewi Lestari | Solo | 6 |

### Jenis Sangkar (4 tipe)
| ID | Nama | Bentuk | Jumlah Bagian |
|----|------|--------|--------------|
| SK-001 | Murai Batu Borneo Premium | Bulat | 6 bagian |
| SK-002 | Lovebird Oval Elegan | Oval | 4 bagian |
| SK-003 | Kacer Hexagon Classic | Hexagon | 6 bagian |
| SK-004 | Kenari Minimalis Box | Kotak | 5 bagian |

### Pesanan Aktif (6 order)
| Kode | Pelanggan | Sangkar | Motif | Status |
|------|-----------|---------|-------|--------|
| SGK-001 | Budi Santoso | Murai Bulat | Batik Parang | 🔵 Printing |
| SGK-002 | Siti Rahayu | Lovebird Oval | Mega Mendung | 🟠 Cutting |
| SGK-003 | Ahmad Fauzi | Kacer Hexagon | Kawung | 🟢 QC |
| SGK-004 | Rina Kusuma | Kenari Kotak | Truntum Jawa | 🩵 Packing |
| SGK-005 | Dodi Pratama | Murai Bulat | Garuda | 🟣 Desain |
| SGK-006 | Heri Purnomo | Murai Bulat | Wayang | 🟣 Desain |

### Desain Decal (8 motif)
| ID | Nama | Kategori | Format |
|----|------|----------|--------|
| DSN-001 | Batik Parang Klasik | Batik | SVG |
| DSN-002 | Mega Mendung Premium | Batik | PNG |
| DSN-003 | Kawung Minimalis | Batik | SVG |
| DSN-004 | Garuda Nusantara | Ornamen | PNG |
| DSN-005 | Bunga Lotus Carving | Ukiran | SVG |
| DSN-006 | Truntum Jawa Heritage | Batik | SVG |
| DSN-007 | Wayang Kulit Silhouette | Budaya | SVG |
| DSN-008 | Parang Barong Bold | Batik | PNG (Draft) |

### Stok Material (12 item) — Status Kritis
| Nama | Stok | Min | Status |
|------|------|-----|--------|
| Tinta Black | 0 ml | 100 ml | 🔴 HABIS |
| Tinta Magenta | 30 ml | 100 ml | 🟡 Menipis |
| Vinyl Transparan | 85 lbr | 100 lbr | 🟡 Menipis |
| *8 item lainnya* | — | — | 🟢 Cukup |

### QC Records (3 record)
| Kode | Inspektor | Hasil |
|------|-----------|-------|
| SGK-002 | Budi Hartono | ✅ Lulus |
| SGK-003 | Budi Hartono | ⚠️ Revisi |
| SGK-004 | Budi Hartono | ✅ Lulus |

---

## 🎯 NILAI UTAMA APLIKASI INI

1. **Desainer tidak perlu lagi mengukur manual** — ukuran semua bagian sangkar sudah tersimpan di sistem
2. **Proses lebih cepat** — desainer langsung buka aplikasi, pilih sangkar, lihat ukuran, mulai desain
3. **Tidak ada miskomunikasi** — catatan motif, bagian, dan ukuran terdokumentasi per pesanan
4. **Tracking real-time** — dari Printing → Cutting → Penempelan → QC → Packing, semua terpantau
5. **Stok terkontrol** — notifikasi otomatis saat tinta atau vinyl menipis
6. **Riwayat terjaga** — semua pesanan, desain, dan QC tersimpan dan bisa diakses kapan saja

---

*Dibuat berdasarkan cerita bisnis aktual dari owner. Diperbarui: Juni 2026*

