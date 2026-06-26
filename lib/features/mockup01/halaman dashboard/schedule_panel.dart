import 'package:flutter/material.dart';

class SchedulePanel extends StatelessWidget {
  const SchedulePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final schedules = [
      {
        "time": "08:30",
        "title": "Printing Decal Murai Borneo",
        "subtitle": "Mesin Epson L1800",
        "icon": Icons.print_rounded,
        "color": Colors.cyan,
      },
      {
        "time": "10:00",
        "title": "Cutting Lovebird Oval",
        "subtitle": "Mesin Cutting Plotter",
        "icon": Icons.content_cut_rounded,
        "color": Colors.orange,
      },
      {
        "time": "13:00",
        "title": "Laminasi Kacer Hexagon",
        "subtitle": "Operator Produksi",
        "icon": Icons.layers_rounded,
        "color": Colors.green,
      },
      {
        "time": "15:00",
        "title": "Quality Control SGK-021",
        "subtitle": "Tim QC",
        "icon": Icons.fact_check_rounded,
        "color": Colors.purpleAccent,
      },
      {
        "time": "16:30",
        "title": "Packing Pesanan SGK-021",
        "subtitle": "Gudang Packing",
        "icon": Icons.inventory_2_rounded,
        "color": Colors.blue,
      },
    ];

    return Container(
      height: 420,
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "JADWAL PRODUKSI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.calendar_today_rounded,
                color: Colors.cyanAccent,
                size: 16,
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text("Hari Ini", style: TextStyle(color: Colors.white54)),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.separated(
              itemCount: schedules.length,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = schedules[index];

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .03),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          item["time"] as String,
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (item["color"] as Color).withValues(
                            alpha: .18,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item["icon"] as IconData,
                          color: item["color"] as Color,
                          size: 22,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["subtitle"] as String,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: const Color(0xFF091121),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.cyan.withValues(alpha: .20)),
    );
  }
}
