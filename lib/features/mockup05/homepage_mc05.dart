import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/desain/desain_page.dart';
import 'package:mocupsangkar/features/mockup01/features/data_sangkar/data_sangkar_page.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

// ============================================================
// HOMEPAGE MOCKUP 05 — Oceanic Teal
// Background : #001A1A  |  Accent: tealAccent
// Navigasi   : Bottom Tab Bar
// Font       : Poppins (global dari main.dart)
// ============================================================

class HomePageMc05 extends StatefulWidget {
  const HomePageMc05({super.key});

  @override
  State<HomePageMc05> createState() => _HomePageMc05State();
}

class _HomePageMc05State extends State<HomePageMc05> {
  int _tabAktif = 0;
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
      backgroundColor: const Color(0xFF001A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002626),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.tealAccent),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Sangkar · Oceanic Teal',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.tealAccent.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.tealAccent.withValues(alpha: .3)),
            ),
            child: const Text(
              'Mockup 05',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.tealAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _tabAktif == 1
            ? const DataSangkarPage(
                accentColor: Colors.tealAccent,
                cardColor: Color(0xFF003333),
                backgroundColor: Color(0xFF001A1A),
              )
            : _tabAktif == 2
                ? const TemplatePage(
                    accentColor: Colors.tealAccent,
                    cardColor: Color(0xFF003333),
                    backgroundColor: Color(0xFF001A1A),
                  )
                : _tabAktif == 3
                    ? const DesainPage()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.waves_rounded, size: 72, color: Colors.tealAccent.withValues(alpha: .8)),
                    const SizedBox(height: 20),
                    const Text('Oceanic Teal',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 24,
                        fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text('Bottom Tab Navigation · Wave Ripple Animation',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white54)),
                    const SizedBox(height: 32),
                    const Text('🚧  Sedang dikembangkan',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.tealAccent)),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: _BottomNavTeal(aktif: _tabAktif, onTap: (i) => setState(() => _tabAktif = i)),
    );
  }
}

class _BottomNavTeal extends StatelessWidget {
  final int aktif;
  final ValueChanged<int> onTap;
  const _BottomNavTeal({required this.aktif, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.dashboard_outlined,              'Dashboard'),
      (Icons.grid_view_rounded,               'Data Sangkar'),
      (Icons.auto_awesome_motion_outlined,    'Template'),
      (Icons.draw_outlined,                   'Desain'),
    ];
    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: Color(0xFF002626),
        border: Border(top: BorderSide(color: Color(0xFF004444))),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final a = i == aktif;
          return Expanded(
            child: InkWell(
              onTap: () => onTap(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(items[i].$1, color: a ? Colors.tealAccent : Colors.white30, size: 22),
                  const SizedBox(height: 3),
                  Text(items[i].$2,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: a ? Colors.tealAccent : Colors.white30,
                      fontWeight: a ? FontWeight.w600 : FontWeight.w400,
                    )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
