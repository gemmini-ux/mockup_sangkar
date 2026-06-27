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
