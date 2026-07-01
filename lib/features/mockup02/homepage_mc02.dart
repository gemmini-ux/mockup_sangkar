import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';
import 'package:mocupsangkar/features/mockup01/features/data_sangkar/data_sangkar_page.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

// ============================================================
// HOMEPAGE MOCKUP 02 — Neon Purple
// Background : #0A0014  |  Accent: purpleAccent
// Navigasi   : Collapsible Sidebar
// Font       : Poppins (global dari main.dart)
// ============================================================

class HomePageMc02 extends StatefulWidget {
  const HomePageMc02({super.key});

  @override
  State<HomePageMc02> createState() => _HomePageMc02State();
}

class _HomePageMc02State extends State<HomePageMc02> {
  bool _sidebarExpanded = true;
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
      backgroundColor: const Color(0xFF0A0014),
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _sidebarExpanded ? 240 : 70,
            color: const Color(0xFF140224),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.purpleAccent, size: 18),
                      onPressed: () => Get.back(),
                    ),
                    if (_sidebarExpanded) ...[
                      const SizedBox(width: 8),
                      const Text(
                        'Neon Purple',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
                const Divider(color: Colors.white12),
                Expanded(
                  child: ListView(
                    children: [
                      _buildMenuItem(Icons.dashboard_outlined, 'Dashboard', 0),
                      _buildMenuItem(Icons.grid_view_rounded, 'Data Sangkar', 1),
                      _buildMenuItem(Icons.auto_awesome_motion_outlined, 'Template', 2),
                      _buildMenuItem(Icons.draw_outlined, 'Desain', 3),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _sidebarExpanded ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                    color: Colors.purpleAccent,
                  ),
                  onPressed: () => setState(() => _sidebarExpanded = !_sidebarExpanded),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _aktifIndex == 1
                  ? const DataSangkarPage(
                      accentColor: Colors.purpleAccent,
                      cardColor: Color(0xFF140224),
                      backgroundColor: Color(0xFF0A0014),
                    )
                  : _aktifIndex == 2
                      ? const TemplatePage(
                          accentColor: Colors.purpleAccent,
                          cardColor: Color(0xFF140224),
                          backgroundColor: Color(0xFF0A0014),
                        )
                      : _aktifIndex == 3
                          ? const DesainPage()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 72,
                            color: Colors.purpleAccent.withValues(alpha: 0.8),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Neon Purple',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Collapsible Sidebar · Glow Pulse Animation',
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
                              color: Colors.purpleAccent,
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
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    final a = index == _aktifIndex;
    return ListTile(
      leading: Icon(icon, color: a ? Colors.purpleAccent : Colors.white30, size: 20),
      title: _sidebarExpanded
          ? Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: a ? Colors.purpleAccent : Colors.white70,
                fontWeight: a ? FontWeight.w600 : FontWeight.w400,
              ),
            )
          : null,
      onTap: () => setState(() => _aktifIndex = index),
    );
  }
}
