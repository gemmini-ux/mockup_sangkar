import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';

// MOCKUP 08 - Sakura Pink | Floating FAB Menu | Bloom Fade
class HomePageMc08 extends StatefulWidget {
  const HomePageMc08({super.key});
  @override
  State<HomePageMc08> createState() => _HomePageMc08State();
}

class _HomePageMc08State extends State<HomePageMc08> {
  bool _fabBuka = false;
  String _aktifMenu = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF220010),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.pinkAccent),
          onPressed: () => Get.back()),
        title: Text(_aktifMenu == 'Desain' ? 'Sakura Desain' : 'Sangkar · Sakura Pink',
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _aktifMenu == 'Desain'
            ? const DesainPage()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_florist_rounded, size: 72, color: Colors.pinkAccent.withAlpha(200)),
                    const SizedBox(height: 20),
                    const Text('Sakura Pink', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text('Floating FAB Menu  |  Masonry Layout  |  Bloom Fade', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white54)),
                    const SizedBox(height: 32),
                    const Text('Sedang dikembangkan...', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.pinkAccent)),
                  ],
                ),
              ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_fabBuka) ...['Dashboard', 'Pesanan', 'Produksi', 'Desain'].map((m) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FloatingActionButton.small(
              heroTag: m,
              backgroundColor: Colors.pinkAccent.withAlpha(200),
              onPressed: () {
                setState(() {
                  _aktifMenu = m;
                  _fabBuka = false;
                });
              },
              child: Text(m[0], style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white)),
            ),
          )),
          const SizedBox(height: 4),
          FloatingActionButton(
            backgroundColor: Colors.pinkAccent,
            onPressed: () => setState(() => _fabBuka = !_fabBuka),
            child: Icon(_fabBuka ? Icons.close : Icons.menu_rounded, color: Colors.white)),
        ],
      ),
    );
  }
}
