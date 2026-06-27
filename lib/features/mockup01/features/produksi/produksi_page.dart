import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';

class ProduksiPage extends StatelessWidget {
  const ProduksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();

    final List<String> kolomList = [
      'Desain',
      'Printing',
      'Cutting',
      'QC',
      'Packing'
    ];

    return Container(
      padding: const EdgeInsets.all(16),
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
            'KANBAN ALUR PRODUKSI DECAL',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          // Caption: size 10 (below 12)
          const Text(
            'Geser status produksi pesanan, verifikasi standar kualitas di tahap QC, dan lakukan pengemasan',
            style: TextStyle(
              fontSize: 10,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 20),

          // Kanban Scroll View (Horizontal)
          Obx(() {
            return SizedBox(
              height: 520,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: kolomList.length,
                itemBuilder: (context, colIndex) {
                  final namaKolom = kolomList[colIndex];
                  
                  // Filter orders matching this column status
                  final ordersDiKolom = controller.orders.where((o) {
                    if (namaKolom == 'QC') {
                      return o.statusProduksi == 'QC';
                    }
                    return o.statusProduksi == namaKolom;
                  }).toList();

                  // Column border glow colors
                  Color headerColor;
                  switch (namaKolom) {
                    case 'Desain':
                      headerColor = Colors.purpleAccent;
                      break;
                    case 'Printing':
                      headerColor = Colors.blueAccent;
                      break;
                    case 'Cutting':
                      headerColor = Colors.orangeAccent;
                      break;
                    case 'QC':
                      headerColor = Colors.greenAccent;
                      break;
                    case 'Packing':
                      headerColor = Colors.cyanAccent;
                      break;
                    default:
                      headerColor = Colors.white;
                  }

                  return Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101B2D).withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Column(
                      children: [
                        // Column Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101B2D),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            border: Border(bottom: BorderSide(color: headerColor, width: 2)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column Title: size 12
                              Text(
                                namaKolom.toUpperCase(),
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: headerColor),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: headerColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // Badge number: size 10 (below 12)
                                child: Text(
                                  '${ordersDiKolom.length}',
                                  style: TextStyle(fontSize: 10, color: headerColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Card List
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: ordersDiKolom.length,
                            itemBuilder: (context, itemIndex) {
                              final o = ordersDiKolom[itemIndex];
                              return _buildKanbanCard(context, o, colIndex, kolomList, controller);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildKanbanCard(
    BuildContext context,
    Pesanan o,
    int colIndex,
    List<String> kolomList,
    OrderController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0A19),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Code: size 10 (below 12)
              Text(
                o.kode,
                style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold),
              ),
              // Qty info: size 10 (below 12)
              Text(
                '${o.qty} Unit',
                style: const TextStyle(fontSize: 10, color: Colors.cyanAccent),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Customer name: size 12
          Text(
            o.pelangganNama,
            style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          // Details: size 10 (below 12)
          Text(
            '${o.jenisSangkar} · ${o.motifDecal}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, color: Colors.white30),
          ),
          const SizedBox(height: 10),
          
          // Action Buttons / QC triggers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left transition button
              colIndex > 0
                  ? InkWell(
                      onTap: () {
                        controller.updateProductionStatus(o.id, kolomList[colIndex - 1]);
                      },
                      child: const Icon(Icons.arrow_circle_left_outlined, color: Colors.white38, size: 20),
                    )
                  : const SizedBox(width: 20),

              // QC specific action
              if (kolomList[colIndex] == 'QC')
                TextButton(
                  onPressed: () {
                    _bukaQcDialog(context, o, controller);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.greenAccent.withValues(alpha: 0.15),
                  ),
                  child: const Text('VERIFIKASI QC', style: TextStyle(fontSize: 10, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                ),

              // Right transition button (moves next or finishes)
              colIndex < kolomList.length - 1
                  ? InkWell(
                      onTap: () {
                        // QC stage forces dialog standard
                        if (kolomList[colIndex] == 'QC') {
                          _bukaQcDialog(context, o, controller);
                        } else {
                          controller.updateProductionStatus(o.id, kolomList[colIndex + 1]);
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined, color: Colors.cyanAccent, size: 20),
                    )
                  : InkWell(
                      onTap: () {
                        // Finish order (status: Selesai)
                        controller.updateProductionStatus(o.id, 'Selesai');
                        Get.snackbar(
                          'SUKSES',
                          'Pesanan ${o.kode} telah selesai diproduksi!',
                          backgroundColor: const Color(0xFF101B2D),
                          colorText: Colors.greenAccent,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 20),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void _bukaQcDialog(BuildContext context, Pesanan o, OrderController controller) {
    bool cetak = true;
    bool potong = true;
    bool tampil = true;
    bool rapi = true;
    String hasil = 'Lulus';
    final notesController = TextEditingController();

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF0C0A19),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.greenAccent.withValues(alpha: 0.3)),
            ),
            title: Text(
              'INSPEKSI QUALITY CONTROL (${o.kode})',
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Periksa fisik stiker decal hasil cetak dan pemotongan sesuai standar berikut:',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  const SizedBox(height: 12),
                  
                  CheckboxListTile(
                    dense: true,
                    activeColor: Colors.greenAccent,
                    checkColor: Colors.black,
                    title: const Text('Kualitas Warna & Cetak', style: TextStyle(fontSize: 12, color: Colors.white)),
                    subtitle: const Text('Warna cerah, tidak blur, tinta kering sempurna', style: TextStyle(fontSize: 10, color: Colors.white38)),
                    value: cetak,
                    onChanged: (val) => setState(() => cetak = val ?? false),
                  ),
                  CheckboxListTile(
                    dense: true,
                    activeColor: Colors.greenAccent,
                    checkColor: Colors.black,
                    title: const Text('Presisi Potongan (Contour Cut)', style: TextStyle(fontSize: 12, color: Colors.white)),
                    subtitle: const Text('Bentuk potongan pas mengikuti pinggir gambar, meleset <0.5mm', style: TextStyle(fontSize: 10, color: Colors.white38)),
                    value: potong,
                    onChanged: (val) => setState(() => potong = val ?? false),
                  ),
                  CheckboxListTile(
                    dense: true,
                    activeColor: Colors.greenAccent,
                    checkColor: Colors.black,
                    title: const Text('Kerapian Tempel / Fisik stiker', style: TextStyle(fontSize: 12, color: Colors.white)),
                    subtitle: const Text('Tidak sobek, tidak bergelembung udara saat perataan', style: TextStyle(fontSize: 10, color: Colors.white38)),
                    value: rapi,
                    onChanged: (val) => setState(() => rapi = val ?? false),
                  ),
                  CheckboxListTile(
                    dense: true,
                    activeColor: Colors.greenAccent,
                    checkColor: Colors.black,
                    title: const Text('Tampilan Akhir Sangkar Berhias', style: TextStyle(fontSize: 12, color: Colors.white)),
                    subtitle: const Text('Motif menempel pas di kubah, kaki, & ruji, terlihat premium', style: TextStyle(fontSize: 10, color: Colors.white38)),
                    value: tampil,
                    onChanged: (val) => setState(() => tampil = val ?? false),
                  ),
                  const Divider(color: Colors.white12),
                  
                  const Text('Hasil Akhir Inspeksi', style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101B2D),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: const Color(0xFF101B2D),
                        value: hasil,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        items: ['Lulus', 'Revisi'].map((h) {
                          return DropdownMenuItem(value: h, child: Text(h));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => hasil = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  const Text('Catatan Inspeksi', style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: notesController,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Masukkan catatan tambahan...',
                      hintStyle: const TextStyle(color: Colors.white30, fontSize: 12),
                      filled: true,
                      fillColor: const Color(0xFF101B2D),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('BATAL', style: TextStyle(color: Colors.white38, fontSize: 12)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Save record
                  controller.addOrUpdateQcRecord(QcRecord(
                    id: 'QC-${DateTime.now().millisecondsSinceEpoch}',
                    pesananId: o.id,
                    pesananKode: o.kode,
                    inspektor: 'Budi Hartono (QC)',
                    tanggal: DateTime.now().toLocal().toString().substring(0, 10),
                    kualitasCetak: cetak,
                    presisiPotongan: potong,
                    tampilanAkhir: tampil,
                    kerapianPenempelan: rapi,
                    hasil: hasil,
                    catatan: notesController.text,
                  ));

                  // Transition status
                  if (hasil == 'Lulus') {
                    controller.updateProductionStatus(o.id, 'Packing');
                    Get.snackbar(
                      'QC LULUS',
                      'Pesanan ${o.kode} telah dipindahkan ke tahap Packing.',
                      backgroundColor: const Color(0xFF101B2D),
                      colorText: Colors.greenAccent,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    controller.updateProductionStatus(o.id, 'Printing'); // Send back to printing
                    Get.snackbar(
                      'QC REVISI',
                      'Pesanan ${o.kode} dikembalikan ke tahap Printing untuk dicetak ulang.',
                      backgroundColor: const Color(0xFF101B2D),
                      colorText: Colors.orangeAccent,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                  Get.back();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.black),
                child: const Text('SIMPAN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }
}

