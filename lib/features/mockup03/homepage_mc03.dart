import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ============================================================
// HOMEPAGE MOCKUP 03 — Clean Minimalist
// Background : #F8F9FA  |  Accent: emerald (Colors.emerald/teal)
// Navigasi   : Top Navigation Bar
// Font       : Poppins (global dari main.dart)
// ============================================================

class HomePageMc03 extends StatefulWidget {
  const HomePageMc03({super.key});

  @override
  State<HomePageMc03> createState() => _HomePageMc03State();
}

class _HomePageMc03State extends State<HomePageMc03> {
  int _aktifIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.teal),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Clean Minimalist',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabItem('Dashboard', 0),
                _buildTabItem('Produksi', 1),
                _buildTabItem('Pesanan', 2),
                _buildTabItem('Stok', 3),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.blur_on_rounded,
              size: 72,
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            const Text(
              'Clean Minimalist',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Top Navigation Bar · Slide-in Animation',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '🚧  Sedang dikembangkan (Draf)',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final a = index == _aktifIndex;
    return InkWell(
      onTap: () => setState(() => _aktifIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: a ? Colors.teal : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: a ? Colors.teal : Colors.black45,
            fontWeight: a ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
