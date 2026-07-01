import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/themed_dashboard.dart';
import 'package:mocupsangkar/features/mockup01/features/data_sangkar/data_sangkar_page.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

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
  void initState() {
    super.initState();
    if (!Get.isRegistered<OrderController>()) Get.put(OrderController());
    if (!Get.isRegistered<StockController>()) Get.put(StockController());
    if (!Get.isRegistered<SangkarController>()) Get.put(SangkarController());
  }

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
        child: _aktifMenu == 'Data Sangkar'
            ? const DataSangkarPage(
                accentColor: Colors.pinkAccent,
                cardColor: Color(0xFF2E0C1B),
                backgroundColor: Color(0xFF1A0A0F),
              )
            : _aktifMenu == 'Template'
                ? const TemplatePage(
                    accentColor: Colors.pinkAccent,
                    cardColor: Color(0xFF2E0C1B),
                    backgroundColor: Color(0xFF1A0A0F),
                  )
                : _aktifMenu == 'Desain'
                    ? const DesainPage()
            : ThemedDashboard(layoutType: 'sakura_pink', accentColor: Colors.pinkAccent, cardColor: Color(0xFF2E0C1B), backgroundColor: Color(0xFF1A0A0F), isLightTheme: false),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_fabBuka) ...['Dashboard', 'Data Sangkar', 'Template', 'Desain'].map((m) => Padding(
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
