// ============================================================
// HOMEPAGE MC01 — RESPONSIVE
// Layout adaptif: Mobile / Tablet / Desktop
//
// Desktop (≥1024px) : Sidebar penuh 260px + konten multi-kolom
// Tablet  (600-1023): Sidebar ikon 72px + konten 2 kolom
// Mobile  (<600px)  : Drawer + navigasi bawah + konten 1 kolom
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/core/responsive.dart';

import 'sidebar_responsive.dart';
import 'topbar_responsive.dart';
import 'stat_card.dart';
import 'features/dashboard/dashboard.dart';
import 'features/dashboard/project_panel.dart';
import 'features/dashboard/activity_panel.dart';
import 'features/dashboard/schedule_panel.dart';
import 'features/dashboard/analytics_card.dart';
import 'features/dashboard/donut_chart_card.dart';
import 'features/dashboard/production_card.dart';
import 'features/dashboard/quick_access_card.dart';
import 'features/dashboard/notification_card.dart';

import 'controllers/order_controller.dart';
import 'controllers/stock_controller.dart';
import 'controllers/sangkar_controller.dart';
import 'features/placeholder/placeholder_page.dart';
import 'features/pesanan/pesanan_page.dart';
import 'features/produksi/produksi_page.dart';
import 'features/desain/desain_page.dart';
import 'features/stok/stok_page.dart';
import 'features/pelanggan/pelanggan_page.dart';
import 'features/template/template_page.dart';
import 'features/data_sangkar/data_sangkar_page.dart';

class HomePageMc01 extends StatefulWidget {
  const HomePageMc01({super.key});

  @override
  State<HomePageMc01> createState() => _HomePageMc01State();
}

class _HomePageMc01State extends State<HomePageMc01> {
  int _menuAktif = 0;
  int _navBawahAktif = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<OrderController>()) {
      Get.put(OrderController());
    }
    if (!Get.isRegistered<StockController>()) {
      Get.put(StockController());
    }
    if (!Get.isRegistered<SangkarController>()) {
      Get.put(SangkarController());
    }
  }

  void _pilihMenu(int i) {
    setState(() {
      _menuAktif = i;
      // Sync bottom navigation index
      switch (i) {
        case 0:
          _navBawahAktif = 0;
          break;
        case 10: // Produksi
          _navBawahAktif = 1;
          break;
        case 11: // Pesanan
          _navBawahAktif = 2;
          break;
        case 6: // Komponen
          _navBawahAktif = 3;
          break;
        case 12: // Pelanggan
          _navBawahAktif = 4;
          break;
        default:
          _navBawahAktif = -1; // Deselected in bottom nav
      }
    });
  }

  void _pilihNavBawah(int i) {
    setState(() {
      _navBawahAktif = i;
      // Sync menu index
      switch (i) {
        case 0:
          _menuAktif = 0;
          break;
        case 1:
          _menuAktif = 10; // Produksi
          break;
        case 2:
          _menuAktif = 11; // Pesanan
          break;
        case 3:
          _menuAktif = 6; // Komponen
          break;
        case 4:
          _menuAktif = 12; // Pelanggan
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _MobileLayout(
        scaffoldKey: _scaffoldKey,
        menuAktif: _menuAktif,
        navBawahAktif: _navBawahAktif,
        onMenuTap: _pilihMenu,
        onNavBawahTap: _pilihNavBawah,
      ),
      tablet: _TabletLayout(
        menuAktif: _menuAktif,
        onMenuTap: _pilihMenu,
      ),
      desktop: _DesktopLayout(
        menuAktif: _menuAktif,
        onMenuTap: _pilihMenu,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DESKTOP LAYOUT  (≥1024px)
// Sidebar penuh + multi-row kolom
// ─────────────────────────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  final int menuAktif;
  final ValueChanged<int> onMenuTap;

  const _DesktopLayout({required this.menuAktif, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712),
      body: Row(
        children: [
          SidebarDesktop(menuAktif: menuAktif, onMenuTap: onMenuTap),

          Expanded(
            child: Column(
              children: [
                const TopbarResponsive(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: _KontenUtama(menuAktif: menuAktif, tipe: TipeLayar.desktop),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// TABLET LAYOUT  (600–1023px)
// Sidebar ikon mini + konten 2 kolom
// ─────────────────────────────────────────────────────────────
class _TabletLayout extends StatelessWidget {
  final int menuAktif;
  final ValueChanged<int> onMenuTap;

  const _TabletLayout({required this.menuAktif, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712),
      body: Row(
        children: [
          SidebarTablet(menuAktif: menuAktif, onMenuTap: onMenuTap),

          Expanded(
            child: Column(
              children: [
                const TopbarResponsive(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: _KontenUtama(menuAktif: menuAktif, tipe: TipeLayar.tablet),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MOBILE LAYOUT  (<600px)
// Drawer + navigasi bawah + konten 1 kolom
// ─────────────────────────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int menuAktif;
  final int navBawahAktif;
  final ValueChanged<int> onMenuTap;
  final ValueChanged<int> onNavBawahTap;

  const _MobileLayout({
    required this.scaffoldKey,
    required this.menuAktif,
    required this.navBawahAktif,
    required this.onMenuTap,
    required this.onNavBawahTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF030712),

      drawer: DrawerMobile(menuAktif: menuAktif, onMenuTap: onMenuTap),

      body: SafeArea(
        child: Column(
          children: [
            TopbarResponsive(
              onHamburgerTap: () => scaffoldKey.currentState?.openDrawer(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: _KontenUtama(menuAktif: menuAktif, tipe: TipeLayar.mobile),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _NavBawah(
        aktif: navBawahAktif,
        onTap: onNavBawahTap,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// NAVIGASI BAWAH — Mobile
// ─────────────────────────────────────────────────────────────
class _NavBawah extends StatelessWidget {
  final int aktif;
  final ValueChanged<int> onTap;

  const _NavBawah({required this.aktif, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.dashboard_outlined, Icons.dashboard_rounded, 'Dashboard'),
      (Icons.precision_manufacturing_outlined, Icons.precision_manufacturing_rounded, 'Produksi'),
      (Icons.shopping_cart_outlined, Icons.shopping_cart_rounded, 'Pesanan'),
      (Icons.inventory_2_outlined, Icons.inventory_2_rounded, 'Stok'),
      (Icons.people_outline, Icons.people_rounded, 'Pelanggan'),
    ];

    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: Color(0xFF07101F),
        border: Border(top: BorderSide(color: Color(0xFF16253C))),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final aktifFlag = i == aktif;
          final item = items[i];
          return Expanded(
            child: InkWell(
              onTap: () => onTap(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    aktifFlag ? item.$2 : item.$1,
                    color: aktifFlag ? Colors.cyanAccent : Colors.white38,
                    size: 22,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.$3,
                    style: TextStyle(
                      color: aktifFlag ? Colors.cyanAccent : Colors.white38,
                      fontSize: 10,
                      fontWeight: aktifFlag ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// KONTEN UTAMA — adaptif berdasarkan TipeLayar & Menu Aktif
// ─────────────────────────────────────────────────────────────
class _KontenUtama extends StatelessWidget {
  final int menuAktif;
  final TipeLayar tipe;
  const _KontenUtama({required this.menuAktif, required this.tipe});

  @override
  Widget build(BuildContext context) {
    if (menuAktif == 0) {
      switch (tipe) {
        case TipeLayar.desktop:
          return _KontenDesktop();
        case TipeLayar.tablet:
          return _KontenTablet();
        case TipeLayar.mobile:
          return _KontenMobile();
      }
    }

    // Sub-halaman fungsional sesuai index menu
    switch (menuAktif) {
      case 1: // Data Sangkar
        return const DataSangkarPage();
      case 2: // Template
        return const TemplatePage();
      case 3: // Desain
        return const DesainPage();
      case 6: // Komponen (Stok)
        return const StokPage();
      case 10: // Produksi
        return const ProduksiPage();
      case 11: // Pesanan
        return const PesananPage();
      case 12: // Pelanggan
        return const PelangganPage();
      default:
        // Render placeholder untuk draf menu lainnya
        final titles = [
          'Dashboard',
          'Data Sangkar',
          'Template',
          'Desain',
          'Tema & Style',
          'Ornamen',
          'Komponen / Stok',
          'AI Prompt',
          'Mapping Editor',
          'Preview 3D',
          'Produksi',
          'Pesanan',
          'Pelanggan',
          'Laporan',
          'Pengaturan'
        ];
        final title = menuAktif < titles.length ? titles[menuAktif] : 'Halaman';
        return PlaceholderPage(title: title);
    }
  }
}

// ── Konten Desktop (multi-kolom penuh) ────────────────────────
class _KontenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DashboardCard(),
        const SizedBox(height: 20),

        // Stat Cards — 5 kolom
        LayoutBuilder(
          builder: (ctx, c) {
            const sp = 14.0;
            final w = (c.maxWidth - sp * 4) / 5;
            return _StatCardWrap(cardWidth: w, spacing: sp);
          },
        ),

        const SizedBox(height: 20),

        // Baris 1 — Produksi : Aktivitas : Jadwal
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: ProjectPanel()),
            SizedBox(width: 16),
            Expanded(flex: 2, child: ActivityPanel()),
            SizedBox(width: 16),
            Expanded(flex: 2, child: SchedulePanel()),
          ],
        ),

        const SizedBox(height: 16),

        // Baris 2 — Donut : Analitik : Produksi
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: DonutChartCard()),
            SizedBox(width: 16),
            Expanded(flex: 2, child: AnalyticsCard()),
            SizedBox(width: 16),
            Expanded(child: ProductionCard()),
          ],
        ),

        const SizedBox(height: 16),

        // Baris 3 — Akses Cepat : Notifikasi
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: QuickAccessCard()),
            SizedBox(width: 16),
            Expanded(child: NotificationCard()),
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ── Konten Tablet (2 kolom) ────────────────────────────────────
class _KontenTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DashboardCard(),
        const SizedBox(height: 16),

        // Stat Cards — 3 kolom
        LayoutBuilder(
          builder: (ctx, c) {
            const sp = 12.0;
            final w = (c.maxWidth - sp * 2) / 3;
            return _StatCardWrap(cardWidth: w, spacing: sp);
          },
        ),

        const SizedBox(height: 16),

        // Antrean + Aktivitas
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ProjectPanel()),
            SizedBox(width: 14),
            Expanded(child: ActivityPanel()),
          ],
        ),

        const SizedBox(height: 14),

        // Jadwal + Produksi
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SchedulePanel()),
            SizedBox(width: 14),
            Expanded(child: ProductionCard()),
          ],
        ),

        const SizedBox(height: 14),

        // Analitik full-width
        const AnalyticsCard(),

        const SizedBox(height: 14),

        // Donut + Notifikasi
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: DonutChartCard()),
            SizedBox(width: 14),
            Expanded(child: NotificationCard()),
          ],
        ),

        const SizedBox(height: 14),

        // Akses Cepat full-width
        const QuickAccessCard(),

        const SizedBox(height: 16),
      ],
    );
  }
}

// ── Konten Mobile (1 kolom penuh) ─────────────────────────────
class _KontenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header ringkas
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang 👋',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const Text(
                    'Admin Produksi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.greenAccent.withValues(alpha: .3)),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Colors.greenAccent),
                    SizedBox(width: 6),
                    Text('Online', style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Stat Cards — 2 kolom
        LayoutBuilder(
          builder: (ctx, c) {
            const sp = 10.0;
            final w = (c.maxWidth - sp) / 2;
            return _StatCardWrap(cardWidth: w, spacing: sp);
          },
        ),

        const SizedBox(height: 14),

        // Status produksi harian — full width
        const ProductionCard(),

        const SizedBox(height: 14),

        // Antrean Produksi — full width
        const ProjectPanel(),

        const SizedBox(height: 14),

        // Akses Cepat — full width
        const QuickAccessCard(),

        const SizedBox(height: 14),

        // Aktivitas — full width
        const ActivityPanel(),

        const SizedBox(height: 14),

        // Jadwal — full width
        const SchedulePanel(),

        const SizedBox(height: 14),

        // 2 kolom bawah
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: DonutChartCard()),
            SizedBox(width: 12),
            Expanded(child: NotificationCard()),
          ],
        ),

        const SizedBox(height: 14),

        // Grafik analitik — full width
        const AnalyticsCard(),

        const SizedBox(height: 24),
      ],
    );
  }
}

// ── StatCard Wrap (bersama untuk semua layout) ─────────────────
class _StatCardWrap extends StatelessWidget {
  final double cardWidth;
  final double spacing;

  const _StatCardWrap({required this.cardWidth, required this.spacing});

  @override
  Widget build(BuildContext context) {
    final cards = [
      (Colors.purple,      Icons.inventory_2_outlined,    'TOTAL DESAIN',  '128'),
      (Colors.greenAccent, Icons.check_circle_outline,    'SELESAI',        '86'),
      (Colors.orange,      Icons.settings,                 'DALAM PROSES',   '24'),
      (Colors.cyan,        Icons.edit_outlined,            'REVISI',         '18'),
      (Colors.blueAccent,  Icons.archive_outlined,         'ARSIP',          '12'),
    ];

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: cards.map((c) {
        return SizedBox(
          width: cardWidth,
          child: StatCard(title: c.$3, value: c.$4, color: c.$1, icon: c.$2),
        );
      }).toList(),
    );
  }
}

