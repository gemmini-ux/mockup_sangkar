import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';

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
              NavigationRailDestination(icon: Icon(Icons.draw_outlined), label: Text('Desain')),
              NavigationRailDestination(icon: Icon(Icons.precision_manufacturing_outlined), label: Text('Produksi')),
              NavigationRailDestination(icon: Icon(Icons.shopping_cart_outlined), label: Text('Pesanan')),
              NavigationRailDestination(icon: Icon(Icons.people_outline), label: Text('CRM')),
            ],
          ),
          const VerticalDivider(color: Color(0xFF1A3A1A), width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _railAktif == 1
                  ? const DesainPage()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.forest_rounded, size: 72, color: Colors.greenAccent.withAlpha(200)),
                          const SizedBox(height: 20),
                          const Text('Forest Green',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 24,
                              fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 8),
                          const Text('Navigation Rail  |  Organic Grow Animation',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white54)),
                          const SizedBox(height: 32),
                          const Text('Sedang dikembangkan...',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.greenAccent)),
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
