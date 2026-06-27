import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/pages/pesanan_form_page.dart';
import 'package:mocupsangkar/models/sangkar_models.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final OrderController controller = Get.find<OrderController>();
  String _searchQuery = '';
  String _selectedFilter = 'Semua';

  final List<String> _statusList = [
    'Semua',
    'Desain',
    'Printing',
    'Cutting',
    'Laminasi',
    'QC',
    'Packing',
    'Selesai'
  ];

  @override
  Widget build(BuildContext context) {
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title size: 16 (larger)
                  const Text(
                    'DAFTAR PESANAN DECAL',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Caption size: 10 (below 12)
                  const Text(
                    'Kelola input pesanan, pantau status pengerjaan stiker, dan cetak instruksi',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(
                    () => const PesananFormPage(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                icon: const Icon(Icons.add, size: 16),
                // Button text: size 12
                label: const Text('TAMBAH PESANAN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Search and Filter Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Cari berdasarkan kode, nama pelanggan, atau motif...',
                    hintStyle: const TextStyle(color: Colors.white30, fontSize: 12),
                    prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent, size: 18),
                    filled: true,
                    fillColor: const Color(0xFF101B2D),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan.withValues(alpha: 0.15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.cyanAccent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.toLowerCase();
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Dropdown Filter: size 12
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF101B2D),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: const Color(0xFF101B2D),
                    value: _selectedFilter,
                    icon: const Icon(Icons.filter_list, color: Colors.cyanAccent, size: 18),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    items: _statusList.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedFilter = val;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Table data
          Obx(() {
            // Apply queries
            final filteredOrders = controller.orders.where((o) {
              final matchSearch = o.kode.toLowerCase().contains(_searchQuery) ||
                  o.pelangganNama.toLowerCase().contains(_searchQuery) ||
                  o.motifDecal.toLowerCase().contains(_searchQuery);
              final matchFilter = _selectedFilter == 'Semua' || o.statusProduksi == _selectedFilter;
              return matchSearch && matchFilter;
            }).toList();

            if (filteredOrders.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'Tidak ada data pesanan ditemukan.',
                    style: TextStyle(color: Colors.white30, fontSize: 12),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFF101B2D)),
                dataRowMinHeight: 56,
                dataRowMaxHeight: 56,
                horizontalMargin: 12,
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('KODE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('PELANGGAN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('SANGKAR', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('MOTIF', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('BAGIAN DECAL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('QTY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('DEADLINE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('STATUS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                  DataColumn(label: Text('AKSI', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent))),
                ],
                rows: filteredOrders.map((o) {
                  // Status badge styling
                  Color statusColor;
                  switch (o.statusProduksi) {
                    case 'Desain':
                      statusColor = Colors.purpleAccent;
                      break;
                    case 'Printing':
                      statusColor = Colors.blueAccent;
                      break;
                    case 'Cutting':
                      statusColor = Colors.orangeAccent;
                      break;
                    case 'Laminasi':
                      statusColor = Colors.tealAccent;
                      break;
                    case 'QC':
                      statusColor = Colors.greenAccent;
                      break;
                    case 'Packing':
                      statusColor = Colors.cyanAccent;
                      break;
                    default:
                      statusColor = Colors.grey;
                  }

                  return DataRow(
                    cells: [
                      // Caption size: 10 (below 12)
                      DataCell(Text(o.kode, style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold))),
                      // Standard size: 12
                      DataCell(Text(o.pelangganNama, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600))),
                      DataCell(Text(o.jenisSangkar, style: const TextStyle(fontSize: 12, color: Colors.white70))),
                      DataCell(Text(o.motifDecal, style: const TextStyle(fontSize: 12, color: Colors.white70))),
                      DataCell(
                        Tooltip(
                          message: o.bagianDecal.join(', '),
                          child: Text(
                            o.bagianDecal.length > 2
                                ? '${o.bagianDecal.take(2).join(', ')} (+${o.bagianDecal.length - 2})'
                                : o.bagianDecal.join(', '),
                            style: const TextStyle(fontSize: 12, color: Colors.white60),
                          ),
                        ),
                      ),
                      DataCell(Text('${o.qty} Unit', style: const TextStyle(fontSize: 12, color: Colors.white))),
                      // Caption size: 10 (below 12)
                      DataCell(Text(o.deadline, style: const TextStyle(fontSize: 10, color: Colors.white38))),
                      DataCell(
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: const Color(0xFF101B2D),
                            value: o.statusProduksi == 'Selesai' ? 'Selesai' : o.statusProduksi,
                            style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.bold),
                            items: _statusList.where((status) => status != 'Semua').map((status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                controller.updateProductionStatus(o.id, val);
                              }
                            },
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.cyanAccent, size: 16),
                              onPressed: () {
                                Get.to(
                                  () => PesananFormPage(order: o),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 300),
                                );
                              },
                              tooltip: 'Edit Order',
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent, size: 16),
                              onPressed: () {
                                _tampilkanDialogHapus(context, o);
                              },
                              tooltip: 'Hapus Order',
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

  void _tampilkanDialogHapus(BuildContext context, Pesanan o) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0C0A19),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.3)),
        ),
        title: const Text(
          'HAPUS PESANAN',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus pesanan ${o.kode} milik ${o.pelangganNama}?',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('BATAL', style: TextStyle(color: Colors.white38, fontSize: 12)),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteOrder(o.id);
              Get.back();
              Get.snackbar(
                'SUKSES',
                'Pesanan ${o.kode} berhasil dihapus',
                backgroundColor: const Color(0xFF101B2D),
                colorText: Colors.greenAccent,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('HAPUS', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
