# 💙 MOCKUP 01 — CYBER DARK BLUE
> **Status:** 🟢 Lengkap & Aktif  
> **Tema Desain:** Cyber-Organic Gelap dengan aksen neon biru/cyan  

---

## 🎨 DESIGN TOKEN & STYLE

*   **Latar Belakang Utama:** `#030712` (Biru sangat gelap)
*   **Warna Permukaan Kartu:** `#091121`
*   **Warna Sidebar:** `#07101F`
*   **Warna Border Sidebar:** `#16253C`
*   **Warna Topbar:** `#0B1424`
*   **Warna Aksen Utama:** `Colors.cyanAccent` (Neon Cyan)
*   **Glow Effect:** Border glowing semi-transparan `Colors.cyan.withOpacity(0.15)`

---

## 🧭 SISTEM NAVIGASI & LAYOUT

*   **Desktop:** Sidebar penuh di sebelah kiri (lebar 260px) + Header Topbar + Konten area multi-kolom responsif.
*   **Tablet:** Sidebar diperkecil (lebar 72px, hanya menampilkan ikon dengan tooltip) + Konten 2 kolom.
*   **Mobile:** Tombol drawer di topbar untuk membuka navigasi samping + Bottom Navigation Bar (5 menu utama: Dashboard, Produksi, Pesanan, Stok, Pelanggan) + Konten 1 kolom.

---

## 🧩 ANIMASI & INTERAKSI KHAS

*   **Sparkline Animation:** Menggambar mini grafik kustom reaktif pada kartu metrik utama.
*   **Progress Bar Glow:** Indikator kemajuan target produksi harian dengan gradasi neon cyan reaktif.
*   **Transisi Halaman:** GetX Page Transition menggunakan efek `Transition.fadeIn` selama 300 milidetik.

---

## 🚀 PEMBARUAN TERBARU (INTERAKTIF)

Kami telah meningkatkan fungsionalitas dan interaktivitas pada halaman **Desain** dan **Sidebar**:

### 1. Lightbox Gambar & Zooming
*   Thumbnail stiker decal pada katalog dilengkapi dengan indikator visual fullscreen (`Icons.fullscreen_rounded`).
*   Mengklik thumbnail gambar akan memunculkan dialog preview `Get.dialog` transparan yang dibungkus dengan `InteractiveViewer` untuk mendukung pinch-to-zoom (cubit zoom) dan geser (pan).

### 2. Panel Detail & Spesifikasi
*   Ditambahkan tombol info (`Icons.info_outline_rounded`) berwarna cyan di setiap kartu decal.
*   Mengklik tombol tersebut menampilkan dialog detail spesifikasi yang memuat data lengkap seperti ID Desain, Kategori, Motif Utama, Ukuran/Dimensi, Format, Resolusi Cetak, Desainer, Tanggal Dibuat, dan Status.

### 3. Penghapusan Desain Reaktif
*   Ditambahkan tombol sampah (`Icons.delete_outline_rounded`) berwarna merah lembut pada kartu stiker.
*   Pemicu dialog konfirmasi sebelum penghapusan data, lalu menghapus item secara reaktif dari `_listDesain` lokal menggunakan `setState` dan memunculkan notifikasi GetX snackbar sukses.

### 4. Dynamic Category & Prompt Creator
*   **Tambah Kategori Baru:** Tombol "+ Tambah" dinamis disematkan pada dialog Generator AI untuk mendaftarkan kategori motif baru tanpa hardcode.
*   **Prompt Saving:** Saat menekan "Generate & Tambah", sistem akan memunculkan dialog bertema Cyber Dark Blue menanyakan apakah prompt tersebut ingin disimpan ke daftar template.
*   **Pilih Prompt Tersimpan:** Tombol "+ Pilih Prompt Tersimpan" di atas input prompt untuk memuat prompt yang pernah dibuat sebelumnya secara instan.

### 5. Logout Fungsional
*   Tombol logout pada desktop sidebar, tablet mini sidebar, dan mobile drawer diaktifkan dengan mengikat event navigasi menggunakan `Get.offAll(() => const HomePage())` setelah menyetujui dialog konfirmasi keluar.

