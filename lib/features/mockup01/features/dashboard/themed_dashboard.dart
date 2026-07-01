import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';

class ThemedDashboard extends StatelessWidget {
  final String layoutType;
  final Color accentColor;
  final Color cardColor;
  final Color backgroundColor;
  final bool isLightTheme;

  const ThemedDashboard({
    super.key,
    required this.layoutType,
    required this.accentColor,
    required this.cardColor,
    required this.backgroundColor,
    this.isLightTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    final OrderController orderCtrl = Get.find<OrderController>();
    final SangkarController sangkarCtrl = Get.find<SangkarController>();

    final textColor = isLightTheme ? Colors.black87 : Colors.white;
    final subtitleColor = isLightTheme ? Colors.black54 : Colors.white60;

    return Obx(() {
      switch (layoutType) {
        case 'neon_purple':
          return _buildNeonPurpleDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'clean_minimalist':
          return _buildCleanMinimalistDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'retro_amber':
          return _buildRetroAmberDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'oceanic_teal':
          return _buildOceanicTealDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'forest_green':
          return _buildForestGreenDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'metallic_crimson':
          return _buildMetallicCrimsonDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'sakura_pink':
          return _buildSakuraPinkDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'cyberpunk_yellow':
          return _buildCyberpunkYellowDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        case 'monochrome_glass':
          return _buildMonochromeGlassDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
        default:
          return _buildDefaultDashboard(orderCtrl, sangkarCtrl, textColor, subtitleColor);
      }
    });
  }

  // =========================================================================
  // 1. NEON PURPLE (MOCKUP 02) — NEON PROGRESS CIRCLES & GLOW GRID
  // =========================================================================
  Widget _buildNeonPurpleDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ANALYTICS HUB — SYSTEM MONITOR',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 2),
        ),
        const SizedBox(height: 16),
        // Neon Circles Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCircularMeter('CETAK', 0.65, Colors.purpleAccent, textColor, subtitleColor),
            _buildCircularMeter('POTONG', 0.45, Colors.pinkAccent, textColor, subtitleColor),
            _buildCircularMeter('QC', 0.85, Colors.cyanAccent, textColor, subtitleColor),
          ],
        ),
        const SizedBox(height: 24),
        // Neon Grid Table
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accentColor.withValues(alpha: 0.25), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MONITORING ANTRIAN PRODUKSI', style: TextStyle(fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 12),
              ...orderCtrl.orders.take(3).map((o) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(width: 4, height: 16, color: accentColor),
                          const SizedBox(width: 8),
                          Text('${o.pelangganNama} — ${o.jenisSangkar}', style: TextStyle(fontSize: 10, color: textColor)),
                        ],
                      ),
                      Text(o.statusProduksi.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: accentColor)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircularMeter(String label, double val, Color meterColor, Color textColor, Color subtitleColor) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CustomPaint(
            painter: _NeonCirclePainter(percent: val, color: meterColor),
            child: Center(
              child: Text('${(val * 100).toInt()}%', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: subtitleColor, fontSize: 9, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // =========================================================================
  // 2. CLEAN MINIMALIST (MOCKUP 03) — FLAT BAR CHART & CLEAN BADGE LISTS
  // =========================================================================
  Widget _buildCleanMinimalistDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview Dashboard',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        // Flat Bar Chart
        Container(
          height: 140,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Volume Order Harian', style: TextStyle(fontSize: 10, color: Colors.black38, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _FlatBarChartPainter(accent: accentColor),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Elegant List
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Daftar Kerangka Aktif', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              ...sangkarCtrl.cages.take(3).map((c) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(c.nama, style: const TextStyle(fontSize: 11, color: Colors.black87)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: accentColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                        child: Text(c.bentuk, style: TextStyle(fontSize: 9, color: accentColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // 3. RETRO AMBER (MOCKUP 04) — VINTAGE LEDGER SHEETS & RETRO CALENDAR
  // =========================================================================
  Widget _buildRetroAmberDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'VINTAGE LEDGER — JOURNAL BOOK',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 1),
        ),
        const SizedBox(height: 16),
        // Ledger Board Container
        Container(
          decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: accentColor, width: 1.0),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: accentColor.withValues(alpha: 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('JOURNAL ENTRY', style: TextStyle(fontFamily: 'Poppins', fontSize: 9, fontWeight: FontWeight.bold, color: accentColor)),
                    Text('REF_ID: 104-X', style: TextStyle(fontFamily: 'Poppins', fontSize: 9, color: subtitleColor)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: orderCtrl.orders.take(3).map((o) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('• ${o.pelangganNama.toUpperCase()}', style: TextStyle(fontFamily: 'Courier', fontSize: 11, color: textColor, fontWeight: FontWeight.bold)),
                          Text('DECAL: ${o.motifDecal}', style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: subtitleColor)),
                          Text('[ ${o.statusProduksi} ]', style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: accentColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Retro Schedule Grid
        Row(
          children: [
            _buildRetroDay('SEN', 'Murai Batu', true),
            const SizedBox(width: 8),
            _buildRetroDay('SEL', 'Kosan R15', false),
            const SizedBox(width: 8),
            _buildRetroDay('RAB', 'Diamond', true),
          ],
        ),
      ],
    );
  }

  Widget _buildRetroDay(String day, String task, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? accentColor.withValues(alpha: 0.08) : cardColor,
          border: Border.all(color: active ? accentColor : Colors.white10),
        ),
        child: Column(
          children: [
            Text(day, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.bold, color: active ? accentColor : Colors.white30)),
            const SizedBox(height: 6),
            Text(task, style: const TextStyle(fontSize: 8, color: Colors.white70), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // 4. OCEANIC TEAL (MOCKUP 05) — WAVE AREA CHART & RIPPLED CARDS
  // =========================================================================
  Widget _buildOceanicTealDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WAVE MATRIX — DECIBEL MONITOR',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 2),
        ),
        const SizedBox(height: 16),
        // Wave Chart Panel
        Container(
          height: 130,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accentColor.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tingkat Produksi Riil', style: TextStyle(fontSize: 9, color: subtitleColor, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: _WaveChartPainter(color: accentColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Rippled Cards Grid
        Row(
          children: [
            _buildRippledCard('ACTIVE PRINT', '4 JOBS', Colors.tealAccent),
            const SizedBox(width: 12),
            _buildRippledCard('LAMINATING', '2 JOBS', Colors.cyanAccent),
          ],
        ),
      ],
    );
  }

  Widget _buildRippledCard(String title, String val, Color highlightColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: highlightColor.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 8, color: Colors.white54, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(val, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: highlightColor)),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // 5. FOREST GREEN (MOCKUP 06) — INVENTORY TREE GRID & GREEN CELLS
  // =========================================================================
  Widget _buildForestGreenDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ECO MONITOR — STOCK TREE',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 1),
        ),
        const SizedBox(height: 16),
        // Tree Inventory List
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accentColor.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Daftar Inventaris Lembaran Decal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 12),
              _buildTreeItem('Bahan Sticker Matte', '95 Lembar (A4)', true),
              _buildTreeItem('Laminasi Glossy Roll', '12 Roll Aktif', false),
              _buildTreeItem('Tinta Cyan/Magenta/Yellow', 'Status Penuh (100%)', true),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Cell status
        Row(
          children: [
            _buildGreenCell('Laminator', 'STABIL'),
            const SizedBox(width: 8),
            _buildGreenCell('Cutter', 'SIAGA'),
          ],
        ),
      ],
    );
  }

  Widget _buildTreeItem(String category, String value, bool isSub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.subdirectory_arrow_right, size: 12, color: accentColor),
          const SizedBox(width: 8),
          Text(category, style: const TextStyle(fontSize: 10, color: Colors.white70)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: accentColor)),
        ],
      ),
    );
  }

  Widget _buildGreenCell(String machine, String status) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: accentColor.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(machine, style: const TextStyle(fontSize: 10, color: Colors.white70)),
            Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: accentColor)),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // 6. METALLIC CRIMSON (MOCKUP 07) — SHIMMER TIMELINE & TOP POPULARITY
  // =========================================================================
  Widget _buildMetallicCrimsonDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CRIMSON PIPELINE — SHIMMER STATUS',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 1),
        ),
        const SizedBox(height: 16),
        // Timeline status
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accentColor.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineStep('1. Pencetakan Decal', 'Proses transfer motif ke stiker', true),
              _buildTimelineStep('2. Laminating Doff/Gloss', 'Pelapisan anti air stiker', true),
              _buildTimelineStep('3. Pemotongan Pola', 'Batas potong menggunakan plotter', false),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Top designs
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accentColor.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Motif Paling Digemari', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 8),
              _buildPopularItem('Red Dragon Fighter', '92% Popularitas'),
              _buildPopularItem('Phoenix Gold Reborn', '87% Popularitas'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineStep(String stepName, String desc, bool isDone) {
    return Row(
      children: [
        Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, size: 16, color: isDone ? accentColor : Colors.white24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stepName, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDone ? Colors.white : Colors.white30)),
            Text(desc, style: const TextStyle(fontSize: 8, color: Colors.white54)),
          ],
        ),
      ],
    );
  }

  Widget _buildPopularItem(String name, String rate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 10, color: Colors.white70)),
          Text(rate, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: accentColor)),
        ],
      ),
    );
  }

  // =========================================================================
  // 7. SAKURA PINK (MOCKUP 08) — MASONRY BLOOM CARDS & PETAL CHART
  // =========================================================================
  Widget _buildSakuraPinkDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SAKURA PETAL GRID — MASONRY LAYOUT',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 1),
        ),
        const SizedBox(height: 16),
        // Petal/Flower Chart
        Container(
          height: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accentColor.withValues(alpha: 0.15)),
          ),
          child: CustomPaint(
            size: const Size(100, 100),
            painter: _SakuraPetalPainter(color: accentColor),
          ),
        ),
        const SizedBox(height: 20),
        // Masonry Cards Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildMasonryCard('PROYEK INDAH', 'Murai Batu Borneo custom decal premium pink sakura border.', 110),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMasonryCard('STATUS AKTIF', '5 Pesanan aktif terdaftar.', 90),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMasonryCard(String title, String content, double height) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 8, color: accentColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Expanded(
            child: Text(content, style: const TextStyle(fontSize: 9, color: Colors.white70), maxLines: 3, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // 8. CYBERPUNK YELLOW (MOCKUP 09) — TERMINAL LOGS & DIAGONAL CHARTS
  // =========================================================================
  Widget _buildCyberpunkYellowDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CYBER SYSTEM CONSOLE // ROOT@DECAL',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 1),
        ),
        const SizedBox(height: 16),
        // Cyberpunk terminal logs console screen
        Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: accentColor, width: 1.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildConsoleLine('SYSTEM STATUS: ONLINE', 'OK'),
                _buildConsoleLine('CONNECTING AI ENGINE...', 'DONE'),
                _buildConsoleLine('LOAD DECAL TEMPLATE CACHE', '12 L'),
                _buildConsoleLine('PRINTER DEVICE PORT: 6301', 'ACTIVE'),
                _buildConsoleLine('INVENTORY MATTE STICKER', '95/100'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Diagonal metrics
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            border: Border(left: BorderSide(color: accentColor, width: 4)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ANTREAN AKTIF SEKARANG', style: TextStyle(fontSize: 10, color: textColor, fontWeight: FontWeight.bold)),
              Text('${orderCtrl.orders.length} PROSES', style: TextStyle(fontSize: 12, color: accentColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConsoleLine(String prompt, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('> $prompt', style: const TextStyle(fontFamily: 'Courier', fontSize: 9, color: Colors.greenAccent)),
          Text('[ $status ]', style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: accentColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // =========================================================================
  // 9. MONOCHROME GLASS (MOCKUP 10) — FROSTED GLASS CONSOLE & MONO GRAPH
  // =========================================================================
  Widget _buildMonochromeGlassDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GLASS CONSOLE — MONOCHROME VISUALS',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: accentColor, letterSpacing: 1),
        ),
        const SizedBox(height: 16),
        // Frosted glass card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rangkuman Skala Cetak', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  Icon(Icons.blur_circular, color: accentColor, size: 18),
                ],
              ),
              const SizedBox(height: 16),
              // Frosted Mono Line Graph
              SizedBox(
                height: 60,
                width: double.infinity,
                child: CustomPaint(
                  painter: _MonoLinePainter(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Frosted metrics
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TOTAL BLUEPRINTS GENERATED', style: TextStyle(fontSize: 9, color: Colors.white60, fontWeight: FontWeight.bold)),
              Text('${sangkarCtrl.templates.length * 8} PCS', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: accentColor)),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // DEFAULT / FALLBACK (MOCKUP 01 STYLE)
  // =========================================================================
  Widget _buildDefaultDashboard(OrderController orderCtrl, SangkarController sangkarCtrl, Color textColor, Color subtitleColor) {
    return Center(
      child: Text('Dashboard Placeholder', style: TextStyle(color: textColor)),
    );
  }
}

// =========================================================================
// CUSTOM PAINTERS FOR THE GRAPHS
// =========================================================================

class _NeonCirclePainter extends CustomPainter {
  final double percent;
  final Color color;
  _NeonCirclePainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paintBg = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final paintFg = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    canvas.drawCircle(center, radius, paintBg);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      paintFg,
    );
  }

  @override
  bool shouldRepaint(covariant _NeonCirclePainter oldDelegate) => oldDelegate.percent != percent || oldDelegate.color != color;
}

class _FlatBarChartPainter extends CustomPainter {
  final Color accent;
  _FlatBarChartPainter({required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accent.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    final paintActive = Paint()
      ..color = accent
      ..style = PaintingStyle.fill;

    final values = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 0.7];
    final double barWidth = size.width / (values.length * 2 - 1);

    for (int i = 0; i < values.length; i++) {
      final double h = size.height * values[i];
      final double x = i * barWidth * 2;
      final double y = size.height - h;
      final rect = Rect.fromLTWH(x, y, barWidth, h);
      
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        i == 3 ? paintActive : paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FlatBarChartPainter oldDelegate) => oldDelegate.accent != accent;
}

class _WaveChartPainter extends CustomPainter {
  final Color color;
  _WaveChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.3, size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final linePath = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.3, size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.4);

    canvas.drawPath(path, paint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _WaveChartPainter oldDelegate) => oldDelegate.color != color;
}

class _SakuraPetalPainter extends CustomPainter {
  final Color color;
  _SakuraPetalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    final paintLine = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width * 0.3;

    for (int i = 0; i < 5; i++) {
      final double angle = (2 * math.pi * i / 5) - math.pi / 2;
      final double px = center.dx + radius * math.cos(angle);
      final double py = center.dy + radius * math.sin(angle);
      
      canvas.drawCircle(Offset(px, py), 12, paint);
      canvas.drawCircle(Offset(px, py), 12, paintLine);
    }
    canvas.drawCircle(center, 8, Paint()..color = Colors.white24);
  }

  @override
  bool shouldRepaint(covariant _SakuraPetalPainter oldDelegate) => oldDelegate.color != color;
}

class _MonoLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.8)
      ..lineTo(size.width * 0.2, size.height * 0.2)
      ..lineTo(size.width * 0.4, size.height * 0.5)
      ..lineTo(size.width * 0.6, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..lineTo(size.width, size.height * 0.1);

    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), paint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _MonoLinePainter oldDelegate) => false;
}
