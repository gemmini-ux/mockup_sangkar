import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';

class ThemedDashboard extends StatelessWidget {
  final Color accentColor;
  final Color cardColor;
  final Color backgroundColor;
  final bool isLightTheme;

  const ThemedDashboard({
    super.key,
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
      final totalOrders = orderCtrl.orders.length;
      final printingOrders = orderCtrl.orders.where((o) => o.statusProduksi == 'Printing').length;
      final cuttingOrders = orderCtrl.orders.where((o) => o.statusProduksi == 'Cutting').length;
      
      final totalTemplates = sangkarCtrl.templates.length;
      final totalCages = sangkarCtrl.cages.length;

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // WELCOME HERO BANNER
            // ==========================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withValues(alpha: 0.15), width: 0.8),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang di Studio Decal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Pantau antrean produksi, cetak blueprint decal, dan buat mockups sangkar 3D.',
                            style: TextStyle(fontSize: 11, color: subtitleColor),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: accentColor,
                        size: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ==========================================
            // METRICS STATS CARDS GRID (4 Cards)
            // ==========================================
            LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                int crossAxisCount = 4;
                if (w < 600) {
                  crossAxisCount = 1;
                } else if (w < 900) {
                  crossAxisCount = 2;
                }
                final double spacing = 12;
                final cardWidth = (w - (spacing * (crossAxisCount - 1))) / crossAxisCount;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    _buildStatCard('Total Pesanan', '$totalOrders', 'Antrean aktif', Icons.shopping_bag_outlined, Colors.purpleAccent, cardWidth, textColor, subtitleColor),
                    _buildStatCard('Cetak & Potong', '${printingOrders + cuttingOrders}', 'Proses produksi', Icons.precision_manufacturing_outlined, Colors.orangeAccent, cardWidth, textColor, subtitleColor),
                    _buildStatCard('Template Sangkar', '$totalTemplates', 'Model siap decal', Icons.category_outlined, Colors.greenAccent, cardWidth, textColor, subtitleColor),
                    _buildStatCard('Kerangka Fisik', '$totalCages', 'Ukuran terdaftar', Icons.grid_view_rounded, accentColor, cardWidth, textColor, subtitleColor),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),

            // ==========================================
            // MAIN 2-COLUMN VIEWPORT
            // ==========================================
            LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                if (w < 900) {
                  return Column(
                    children: [
                      _buildProductionPanel(orderCtrl, textColor, subtitleColor),
                      const SizedBox(height: 20),
                      _buildActivityPanel(sangkarCtrl, orderCtrl, textColor, subtitleColor),
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildProductionPanel(orderCtrl, textColor, subtitleColor),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: _buildActivityPanel(sangkarCtrl, orderCtrl, textColor, subtitleColor),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatCard(
    String label,
    String value,
    String desc,
    IconData icon,
    Color cardAccent,
    double width,
    Color textColor,
    Color subtitleColor,
  ) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.1), width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: cardAccent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 10, color: subtitleColor, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                const SizedBox(height: 2),
                Text(desc, style: TextStyle(fontSize: 8, color: subtitleColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductionPanel(OrderController ctrl, Color textColor, Color subtitleColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.1), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Antrean Alur Produksi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textColor)),
              Icon(Icons.trending_up, color: accentColor, size: 16),
            ],
          ),
          const SizedBox(height: 16),
          if (ctrl.orders.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Tidak ada pesanan aktif.', style: TextStyle(color: subtitleColor, fontSize: 11)),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ctrl.orders.take(5).length,
              separatorBuilder: (context, idx) => const Divider(color: Colors.white10, height: 16),
              itemBuilder: (context, idx) {
                final o = ctrl.orders[idx];
                Color statusColor = Colors.cyanAccent;
                if (o.statusProduksi == 'Printing') statusColor = Colors.orangeAccent;
                if (o.statusProduksi == 'Selesai') statusColor = Colors.greenAccent;
                if (o.statusProduksi == 'Cutting') statusColor = Colors.purpleAccent;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(o.pelangganNama, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor)),
                        const SizedBox(height: 4),
                        Text('${o.jenisSangkar} • Motif: ${o.motifDecal}', style: TextStyle(fontSize: 9, color: subtitleColor)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 0.5),
                      ),
                      child: Text(
                        o.statusProduksi.toUpperCase(),
                        style: TextStyle(color: statusColor, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildActivityPanel(SangkarController sangkarCtrl, OrderController orderCtrl, Color textColor, Color subtitleColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.1), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Aktivitas Terakhir', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textColor)),
              Icon(Icons.history, color: accentColor, size: 16),
            ],
          ),
          const SizedBox(height: 16),
          _buildActivityItem('Pesanan baru terdaftar', 'Pesanan kustom sangkar Murai Batu', 'Baru saja', accentColor, textColor, subtitleColor),
          const Divider(color: Colors.white10, height: 16),
          _buildActivityItem('Stiker Decal dicetak', 'Layout decal Kosan R15 diproses print', '15m lalu', Colors.orangeAccent, textColor, subtitleColor),
          const Divider(color: Colors.white10, height: 16),
          _buildActivityItem('Template disimpan', 'Template sangkar ceper berhasil diregistrasi', '1j lalu', Colors.greenAccent, textColor, subtitleColor),
          const Divider(color: Colors.white10, height: 16),
          _buildActivityItem('Laminasi Selesai', 'Laminating gloss pada decal selesai dikerjakan', '2j lalu', Colors.purpleAccent, textColor, subtitleColor),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String desc,
    String time,
    Color circleColor,
    Color textColor,
    Color subtitleColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 2),
              Text(desc, style: TextStyle(fontSize: 9, color: subtitleColor)),
            ],
          ),
        ),
        Text(time, style: TextStyle(fontSize: 8, color: subtitleColor)),
      ],
    );
  }
}
