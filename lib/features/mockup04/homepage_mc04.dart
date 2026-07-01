import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';
import 'package:mocupsangkar/features/mockup01/features/data_sangkar/data_sangkar_page.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

// ============================================================
// HOMEPAGE MOCKUP 04 — Retro Amber
// Background : #1A1000  |  Accent: Colors.amber
// Navigasi   : Right Sidebar
// Font       : Poppins (global dari main.dart)
// ============================================================

class HomePageMc04 extends StatefulWidget {
  const HomePageMc04({super.key});

  @override
  State<HomePageMc04> createState() => _HomePageMc04State();
}

class _HomePageMc04State extends State<HomePageMc04> {
  int _aktifIndex = 0;
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<OrderController>()) Get.put(OrderController());
    if (!Get.isRegistered<StockController>()) Get.put(StockController());
    if (!Get.isRegistered<SangkarController>()) Get.put(SangkarController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1000),
      body: Row(
        children: [
          // Body (Left side)
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: const Color(0xFF261800),
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.amber),
                    onPressed: () => Get.back(),
                  ),
                  title: const Text(
                    'Retro Amber',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _aktifIndex == 1
                        ? const DataSangkarPage(
                            accentColor: Colors.amber,
                            cardColor: Color(0xFF261800),
                            backgroundColor: Color(0xFF1A1000),
                          )
                        : _aktifIndex == 2
                            ? const TemplatePage(
                                accentColor: Colors.amber,
                                cardColor: Color(0xFF261800),
                                backgroundColor: Color(0xFF1A1000),
                              )
                            : _aktifIndex == 3
                                ? const DesainPage()
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.radar_rounded,
                                  size: 72,
                                  color: Colors.amber.withValues(alpha: 0.8),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Retro Amber',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Right Sidebar · Vintage Grid Layout · Fade + Sepia',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                const Text(
                                  '🚧  Sedang dikembangkan (Draf)',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          // Sidebar (Right side)
          Container(
            width: 200,
            color: const Color(0xFF261800),
            child: Column(
              children: [
                const SizedBox(height: 48),
                const Text(
                  'NAVIGASI',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white30,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSidebarItem(Icons.dashboard_outlined, 'Dashboard', 0),
                _buildSidebarItem(Icons.grid_view_rounded, 'Data Sangkar', 1),
                _buildSidebarItem(Icons.auto_awesome_motion_outlined, 'Template', 2),
                _buildSidebarItem(Icons.draw_outlined, 'Desain', 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, int index) {
    final a = index == _aktifIndex;
    return ListTile(
      trailing: Icon(icon, color: a ? Colors.amber : Colors.white30, size: 20),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: a ? Colors.amber : Colors.white70,
            fontWeight: a ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      onTap: () => setState(() => _aktifIndex = index),
    );
  }
}
