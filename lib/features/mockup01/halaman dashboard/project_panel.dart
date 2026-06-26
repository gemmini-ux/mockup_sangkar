import 'package:flutter/material.dart';

class ProjectPanel extends StatelessWidget {
  const ProjectPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "kode": "SGK-001",
        "nama": "Murai Borneo Premium",
        "status": "Printing",
        "qty": "25",
      },
      {
        "kode": "SGK-002",
        "nama": "Lovebird Elegan",
        "status": "Cutting",
        "qty": "18",
      },
      {"kode": "SGK-003", "nama": "Kacer Hexagon", "status": "QC", "qty": "12"},
      {
        "kode": "SGK-004",
        "nama": "Kenari Minimalis",
        "status": "Packing",
        "qty": "30",
      },
      {
        "kode": "SGK-005",
        "nama": "Anis Merah Luxury",
        "status": "Desain",
        "qty": "15",
      },
    ];

    return Container(
      height: 420,
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ANTRIAN PRODUKSI",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text("Lihat Semua", style: TextStyle(color: Colors.white54)),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.separated(
              itemCount: orders.length,
              separatorBuilder: (_, _) => const Divider(color: Colors.white10),
              itemBuilder: (context, index) {
                final item = orders[index];

                return ListTile(
                  contentPadding: EdgeInsets.zero,

                  leading: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.catching_pokemon,
                      color: Colors.orangeAccent,
                    ),
                  ),

                  title: Text(
                    item["nama"]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  subtitle: Text(
                    "${item["kode"]} • Qty ${item["qty"]}",
                    style: const TextStyle(color: Colors.white54),
                  ),

                  trailing: _status(item["status"]!),
                );
              },
            ),
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
