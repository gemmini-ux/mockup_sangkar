import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/controllers/stock_controller.dart';

class StokPage extends StatelessWidget {
  const StokPage({super.key});

  @override
  Widget build(BuildContext context) {
    final StockController controller = Get.find<StockController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF091121),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: size 16 (larger)
          const Text(
            'INVENTARIS - STOK MATERIAL',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          // Subtext/Caption: size 10 (below 12)
          const Text(
            'Menampilkan stok tinta, stiker vinyl, dan pelapis laminasi secara real-time',
            style: TextStyle(
              fontSize: 10,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 20),

          Obx(() {
            final listStok = controller.stockItems;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFF101B2D)),
                dataRowMinHeight: 52,
                dataRowMaxHeight: 52,
                horizontalMargin: 12,
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('MATERIAL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('KATEGORI', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('STOK SAAT INI', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('MINIMUM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('STATUS LEVEL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('PEMASOK', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('TANGGAL UPDATE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('SESUAIKAN STOK', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                ],
                rows: listStok.map((item) {
                  Color statusColor;
                  Color statusBg;
                  switch (item.levelStok) {
                    case 'Habis':
                      statusColor = Colors.redAccent;
                      statusBg = Colors.red.withValues(alpha: 0.15);
                      break;
                    case 'Menipis':
                      statusColor = Colors.orangeAccent;
                      statusBg = Colors.orange.withValues(alpha: 0.15);
                      break;
                    default:
                      statusColor = Colors.greenAccent;
                      statusBg = Colors.green.withValues(alpha: 0.15);
                  }

                  // Determine adjustment amount based on unit type
                  int adjustAmount = 10;
                  if (item.satuan == 'ml') {
                    adjustAmount = 50;
                  }

                  return DataRow(
                    cells: [
                      // Standard text: size 12
                      DataCell(Text(item.nama, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600))),
                      DataCell(Text(item.kategori, style: const TextStyle(fontSize: 12, color: Colors.white70))),
                      DataCell(Text('${item.stokSaat} ${item.satuan}', style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold))),
                      DataCell(Text('${item.stokMinimum} ${item.satuan}', style: const TextStyle(fontSize: 12, color: Colors.white38))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            item.levelStok.toUpperCase(),
                            style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(Text(item.pemasok, style: const TextStyle(fontSize: 12, color: Colors.white60))),
                      // Caption size: 10 (below 12)
                      DataCell(Text(item.tanggalUpdate, style: const TextStyle(fontSize: 10, color: Colors.white38))),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                              onPressed: () => controller.adjustStock(item.id, -adjustAmount),
                              tooltip: 'Kurangi $adjustAmount',
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.greenAccent, size: 20),
                              onPressed: () => controller.adjustStock(item.id, adjustAmount),
                              tooltip: 'Tambah $adjustAmount',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
