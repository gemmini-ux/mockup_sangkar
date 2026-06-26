import 'package:flutter/material.dart';
import 'package:get/get.dart';

// MOCKUP 09 - Cyberpunk Yellow | Diagonal Sidebar | Glitch Flash
class HomePageMc09 extends StatelessWidget {
  const HomePageMc09({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A00),
      body: Row(
        children: [
          Container(
            width: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A1A00), Color(0xFF0A0A00)],
              ),
              border: Border(right: BorderSide(color: Color(0xFF333300))),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.yellowAccent, size: 18),
                      onPressed: () => Get.back()),
                    const Text('SANGKAR', style: TextStyle(fontFamily: 'Poppins', fontSize: 14,
                      fontWeight: FontWeight.bold, color: Colors.yellowAccent, letterSpacing: 2)),
                  ],
                ),
                const Divider(color: Color(0xFF333300)),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    children: ['Dashboard', 'Produksi', 'Pesanan', 'Stok', 'Laporan'].map((m) =>
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: Colors.yellowAccent.withAlpha(80), width: 2)),
                        ),
                        child: ListTile(dense: true,
                          contentPadding: const EdgeInsets.only(left: 12),
                          title: Text(m, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white70)),
                          onTap: () {}),
                      )).toList(),
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
                  Icon(Icons.bolt_rounded, size: 72, color: Colors.yellowAccent.withAlpha(200)),
                  const SizedBox(height: 20),
                  const Text('Cyberpunk Yellow', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Diagonal Sidebar  |  Offset Grid  |  Glitch Flash', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white54)),
                  const SizedBox(height: 32),
                  const Text('Sedang dikembangkan...', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.yellowAccent)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
