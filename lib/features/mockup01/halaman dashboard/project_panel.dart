import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';

class ProjectPanel extends StatelessWidget {
  const ProjectPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();

    return Container(
      height: 420,
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ANTRIAN PRODUKSI",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Obx(() {
              final activeOrders = controller.orders.take(5).toList();

              if (activeOrders.isEmpty) {
                return const Center(
                  child: Text(
                    "Tidak ada antrean aktif",
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                );
              }

              return ListView.separated(
                itemCount: activeOrders.length,
                separatorBuilder: (_, _) => const Divider(color: Colors.white10),
                itemBuilder: (context, index) {
                  final item = activeOrders[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.bookmark_added_outlined,
                        color: Colors.cyanAccent,
                        size: 20,
                      ),
                    ),

                    title: Text(
                      item.jenisSangkar,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),

                    subtitle: Text(
                      "${item.kode} • Qty ${item.qty} · ${item.pelangganNama}",
                      style: const TextStyle(color: Colors.white54, fontSize: 10),
                    ),

                    trailing: _status(item.statusProduksi),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _status(String status) {
    Color color;

    switch (status) {
      case "Desain":
        color = Colors.purpleAccent;
        break;
      case "Printing":
        color = Colors.blueAccent;
        break;
      case "Cutting":
        color = Colors.orange;
        break;
      case "QC":
        color = Colors.green;
        break;
      case "Packing":
        color = Colors.cyan;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: const Color(0xFF091121),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.cyan.withValues(alpha: .2)),
    );
  }
}
