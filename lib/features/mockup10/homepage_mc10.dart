import 'package:flutter/material.dart';
import 'package:get/get.dart';

// MOCKUP 10 - Monochrome Glass | Glass Overlay Navigation | Frosted Reveal
class HomePageMc10 extends StatefulWidget {
  const HomePageMc10({super.key});
  @override
  State<HomePageMc10> createState() => _HomePageMc10State();
}

class _HomePageMc10State extends State<HomePageMc10> {
  bool _navBuka = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Stack(
        children: [
          // ── Konten Utama ─────────────────────────────────
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.blur_on_rounded, size: 72, color: Colors.white54),
                const SizedBox(height: 20),
                const Text('Monochrome Glass',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 24,
                    fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Glass Overlay Nav  |  Full Backdrop Blur  |  Frosted Reveal',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white54)),
                const SizedBox(height: 32),
                const Text('Sedang dikembangkan...',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white38)),
              ],
            ),
          ),

          // ── Tombol Buka Nav ──────────────────────────────
          Positioned(
            top: 20, left: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white54, size: 18),
                  onPressed: () => Get.back()),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => setState(() => _navBuka = !_navBuka),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withAlpha(30)),
                    ),
                    child: const Text('☰  Menu',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ),

          // ── Glass Overlay Navigation ─────────────────────
          if (_navBuka)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _navBuka = false),
                child: Container(color: Colors.black.withAlpha(120)),
              ),
            ),
          if (_navBuka)
            Positioned(
              top: 0, left: 0, bottom: 0,
              width: 260,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(12),
                  border: Border(right: BorderSide(color: Colors.white.withAlpha(20))),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Text('SANGKAR STUDIO',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 13,
                          fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 2)),
                      const Divider(color: Colors.white12),
                      ...['Dashboard', 'Produksi', 'Pesanan', 'Stok', 'Pelanggan', 'Laporan', 'Pengaturan']
                        .map((m) => ListTile(
                          title: Text(m, style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 12, color: Colors.white60)),
                          onTap: () => setState(() => _navBuka = false))),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
