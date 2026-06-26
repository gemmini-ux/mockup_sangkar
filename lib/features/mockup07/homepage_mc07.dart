import 'package:flutter/material.dart';
import 'package:get/get.dart';

// MOCKUP 07 - Metallic Crimson | Sidebar + Header Row | Shimmer
class HomePageMc07 extends StatelessWidget {
  const HomePageMc07({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0000),
      body: Row(
        children: [
          Container(
            width: 240,
            color: const Color(0xFF220000),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xFF2A0000),
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.redAccent, size: 18), onPressed: () => Get.back()),
                      const SizedBox(width: 8),
                      const Text('SANGKAR', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    children: ['Dashboard', 'Produksi', 'Pesanan', 'Stok', 'Pelanggan', 'Laporan', 'Pengaturan'].map((m) =>
                      ListTile(dense: true,
                        title: Text(m, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white70)),
                        onTap: () {})).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_fire_department_rounded, size: 72, color: Colors.redAccent.withAlpha(200)),
                  const SizedBox(height: 20),
                  const Text('Metallic Crimson', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Sidebar + Header  |  Shimmer Effect', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white54)),
                  const SizedBox(height: 32),
                  const Text('Sedang dikembangkan...', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.redAccent)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
