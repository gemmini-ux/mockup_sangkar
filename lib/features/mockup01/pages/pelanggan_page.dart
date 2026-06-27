import 'package:flutter/material.dart';
import 'package:mocupsangkar/data/dummy_db.dart';

class PelangganPage extends StatelessWidget {
  const PelangganPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listPelanggan = DummyDb.pelanggan;

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
            'CRM - DATA PELANGGAN',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          // Subtext/Caption: size 10 (below 12)
          Text(
            'Menampilkan total ${listPelanggan.length} pelanggan terdaftar',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 20),

          // Responsive Table wrapper
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFF101B2D)),
              dataRowMinHeight: 48,
              dataRowMaxHeight: 48,
              horizontalMargin: 12,
              columnSpacing: 24,
              columns: const [
                DataColumn(
                  label: Text('ID', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
                DataColumn(
                  label: Text('NAMA PELANGGAN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
                DataColumn(
                  label: Text('KOTA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
                DataColumn(
                  label: Text('TELEPON', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
                DataColumn(
                  label: Text('EMAIL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
                DataColumn(
                  label: Text('ORDERS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
                DataColumn(
                  label: Text('TOTAL BELANJA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
                DataColumn(
                  label: Text('BERGABUNG', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ),
              ],
              rows: listPelanggan.map((p) {
                return DataRow(
                  cells: [
                    // Meta info: size 10 (below 12)
                    DataCell(Text(p.id, style: const TextStyle(fontSize: 10, color: Colors.white54))),
                    // Standard text: size 12
                    DataCell(Text(p.nama, style: const TextStyle(fontSize: 12, color: Colors.white))),
                    DataCell(Text(p.kota, style: const TextStyle(fontSize: 12, color: Colors.white70))),
                    DataCell(Text(p.telepon, style: const TextStyle(fontSize: 12, color: Colors.white70))),
                    DataCell(Text(p.email, style: const TextStyle(fontSize: 12, color: Colors.white60))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${p.totalPesanan}x',
                          style: const TextStyle(fontSize: 11, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataCell(Text(p.totalBelanja, style: const TextStyle(fontSize: 12, color: Colors.greenAccent, fontWeight: FontWeight.bold))),
                    // Meta date: size 10 (below 12)
                    DataCell(Text(p.bergabungSejak, style: const TextStyle(fontSize: 10, color: Colors.white38))),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
