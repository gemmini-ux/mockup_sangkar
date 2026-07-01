import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/themed_dashboard.dart';
import 'package:mocupsangkar/features/mockup01/features/data_sangkar/data_sangkar_page.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

// MOCKUP 10 - Monochrome Glass | Glass Overlay Navigation | Frosted Reveal
class HomePageMc10 extends StatefulWidget {
  const HomePageMc10({super.key});
  @override
  State<HomePageMc10> createState() => _HomePageMc10State();
}

class _HomePageMc10State extends State<HomePageMc10> {
  bool _navBuka = false;
  String _aktifMenu = 'Dashboard';
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
      backgroundColor: const Color(0xFF101010),
      body: Stack(
        children: [
          // ── Konten Utama ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
            child: _aktifMenu == 'Data Sangkar'
                ? const DataSangkarPage(
                    accentColor: Colors.white,
                    cardColor: Color(0xFF1E1E1E),
                    backgroundColor: Color(0xFF101010),
                  )
                : _aktifMenu == 'Template'
                    ? const TemplatePage(
                        accentColor: Colors.white,
                        cardColor: Color(0xFF1E1E1E),
                        backgroundColor: Color(0xFF101010),
                      )
                    : _aktifMenu == 'Desain'
                        ? const DesainPage()
                : ThemedDashboard(layoutType: 'monochrome_glass', accentColor: Colors.white, cardColor: Color(0xFF1E1E1E), backgroundColor: Color(0xFF101010), isLightTheme: false),
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
                    child: Text('☰  Menu (${_aktifMenu == 'Desain' ? 'Desain' : 'Dashboard'})',
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white70)),
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
                  color: const Color(0xFF1E1E1E),
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
                      ...['Dashboard', 'Data Sangkar', 'Template', 'Desain']
                        .map((m) => ListTile(
                          title: Text(m, style: TextStyle(
                            fontFamily: 'Poppins', fontSize: 12, color: m == _aktifMenu ? Colors.white : Colors.white60, fontWeight: m == _aktifMenu ? FontWeight.bold : FontWeight.normal)),
                          onTap: () => setState(() {
                            _aktifMenu = m;
                            _navBuka = false;
                          }))),
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
