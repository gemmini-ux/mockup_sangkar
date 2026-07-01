import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';
import 'package:mocupsangkar/features/mockup01/features/data_sangkar/data_sangkar_page.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

// MOCKUP 07 - Metallic Crimson | Sidebar + Header Row | Shimmer
class HomePageMc07 extends StatefulWidget {
  const HomePageMc07({super.key});

  @override
  State<HomePageMc07> createState() => _HomePageMc07State();
}

class _HomePageMc07State extends State<HomePageMc07> {
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
    final menus = ['Dashboard', 'Data Sangkar', 'Template', 'Desain'];

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
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    itemCount: menus.length,
                    itemBuilder: (context, i) {
                      final m = menus[i];
                      final isSelected = i == _aktifIndex;
                      return ListTile(
                        dense: true,
                        title: Text(m, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: isSelected ? Colors.redAccent : Colors.white70, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                        onTap: () => setState(() => _aktifIndex = i),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _aktifIndex == 1
                  ? const DataSangkarPage(
                      accentColor: Colors.redAccent,
                      cardColor: Color(0xFF2D0A0A),
                      backgroundColor: Color(0xFF1A0A0A),
                    )
                  : _aktifIndex == 2
                      ? const TemplatePage(
                          accentColor: Colors.redAccent,
                          cardColor: Color(0xFF2D0A0A),
                          backgroundColor: Color(0xFF1A0A0A),
                        )
                      : _aktifIndex == 3
                          ? const DesainPage()
                  : Center(
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
          ),
        ],
      ),
    );
  }
}
