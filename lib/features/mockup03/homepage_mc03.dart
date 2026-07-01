import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/themed_dashboard.dart';
import 'package:mocupsangkar/features/mockup01/features/data_sangkar/data_sangkar_page.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

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
  void initState() {
    super.initState();
    if (!Get.isRegistered<OrderController>()) Get.put(OrderController());
    if (!Get.isRegistered<StockController>()) Get.put(StockController());
    if (!Get.isRegistered<SangkarController>()) Get.put(SangkarController());
  }

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
                _buildTabItem('Data Sangkar', 1),
                _buildTabItem('Template', 2),
                _buildTabItem('Desain', 3),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _aktifIndex == 1
            ? const DataSangkarPage(
                accentColor: Colors.teal,
                cardColor: Colors.white,
                backgroundColor: Color(0xFFF8F9FA),
                isLightTheme: true,
              )
            : _aktifIndex == 2
                ? const TemplatePage(
                    accentColor: Colors.teal,
                    cardColor: Colors.white,
                    backgroundColor: Color(0xFFF8F9FA),
                    isLightTheme: true,
                  )
                : _aktifIndex == 3
                    ? const DesainPage()
            : ThemedDashboard(accentColor: Colors.teal, cardColor: Colors.white, backgroundColor: Color(0xFFF8F9FA), isLightTheme: true),
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
