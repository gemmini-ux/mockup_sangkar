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
// HOMEPAGE MOCKUP 06 - Forest Green
// Background : #0A1A0A  |  Accent: greenAccent
// Navigasi   : Navigation Rail (kiri, compak)
// Font       : Poppins (global dari main.dart)
// ============================================================

class HomePageMc06 extends StatefulWidget {
  const HomePageMc06({super.key});
  @override
  State<HomePageMc06> createState() => _HomePageMc06State();
}

class _HomePageMc06State extends State<HomePageMc06> {
  int _railAktif = 0;
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
      backgroundColor: const Color(0xFF0A1A0A),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: const Color(0xFF122012),
            selectedIndex: _railAktif,
            onDestinationSelected: (i) => setState(() => _railAktif = i),
            indicatorColor: Colors.greenAccent.withAlpha(40),
            selectedIconTheme: const IconThemeData(color: Colors.greenAccent),
            unselectedIconTheme: const IconThemeData(color: Colors.white30),
            selectedLabelTextStyle: const TextStyle(
              fontFamily: 'Poppins', fontSize: 10, color: Colors.greenAccent),
            unselectedLabelTextStyle: const TextStyle(
              fontFamily: 'Poppins', fontSize: 10, color: Colors.white30),
            labelType: NavigationRailLabelType.all,
            leading: Column(
              children: [
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.greenAccent, size: 18),
                  onPressed: () => Get.back()),
              ],
            ),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), label: Text('Board')),
              NavigationRailDestination(icon: Icon(Icons.grid_view_rounded), label: Text('Data Sangkar')),
              NavigationRailDestination(icon: Icon(Icons.auto_awesome_motion_outlined), label: Text('Template')),
              NavigationRailDestination(icon: Icon(Icons.draw_outlined), label: Text('Desain')),
            ],
          ),
          const VerticalDivider(color: Color(0xFF1A3A1A), width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _railAktif == 1
                  ? const DataSangkarPage(
                      accentColor: Colors.greenAccent,
                      cardColor: Color(0xFF142E14),
                      backgroundColor: Color(0xFF0A1A0A),
                    )
                  : _railAktif == 2
                      ? const TemplatePage(
                          accentColor: Colors.greenAccent,
                          cardColor: Color(0xFF142E14),
                          backgroundColor: Color(0xFF0A1A0A),
                        )
                      : _railAktif == 3
                          ? const DesainPage()
                  : ThemedDashboard(layoutType: 'forest_green', accentColor: Colors.greenAccent, cardColor: Color(0xFF142E14), backgroundColor: Color(0xFF0A1A0A), isLightTheme: false),
            ),
          ),
        ],
      ),
    );
  }
}
