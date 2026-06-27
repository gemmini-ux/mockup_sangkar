# 💜 MOCKUP 02 — NEON PURPLE
> **Status:** 🟡 Draf / Templat Placeholder  
> **Tema Desain:** Cyberpunk Gelap Misterius dengan pendaran neon ungu  

---

## 🎨 DESIGN TOKEN & STYLE

*   **Latar Belakang Utama:** `#0A0014` (Hitam keunguan sangat pekat)
*   **Warna Permukaan Kartu:** `#140224` (Ungu gelap transparan)
*   **Warna Aksen Utama:** `Colors.purpleAccent` / Fuchsia
*   **Glow Effect:** Efek bayangan pendaran ungu (`glowPurple` atau fuchsia glow)

---

## 🧭 SISTEM NAVIGASI & LAYOUT

*   **Navigasi Utama:** Sidebar yang dapat diciutkan (*Collapsible Sidebar*). 
    *   Saat dilebarkan (lebar 240px), menampilkan teks nama menu.
    *   Saat diciutkan (lebar 70px), hanya menampilkan ikon menu untuk menghemat area workspace.
*   **Layout Khas:** Grid kartu melayang (*floating card grid layout*) dengan bayangan berpendar tebal.

---

## 🧩 ANIMASI & INTERAKSI KHAS

*   **Glow Pulse Animation:** Pendaran warna border kartu metrik utama membesar dan mengecil secara halus (*breathing animation*).
*   **Slide Expansion:** Efek transisi pelebaran sidebar menggunakan `AnimatedContainer` dengan kurva akselerasi `Curves.easeInOut`.
