import 'package:flutter/material.dart';

class ActivityPanel extends StatelessWidget {
  const ActivityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        "icon": Icons.add_box_rounded,
        "color": Colors.cyan,
        "title": "Template Murai Borneo berhasil ditambahkan",
        "user": "Andi Setiawan",
        "time": "08:15",
      },
      {
        "icon": Icons.design_services_rounded,
        "color": Colors.purpleAccent,
        "title": "Mockup Lovebird Oval selesai dibuat",
        "user": "Dina Pratiwi",
        "time": "09:00",
      },
      {
        "icon": Icons.picture_as_pdf_rounded,
        "color": Colors.orange,
        "title": "Export PDF SGK-003 berhasil",
        "user": "Rizky Saputra",
        "time": "09:45",
      },
      {
        "icon": Icons.print_rounded,
        "color": Colors.green,
        "title": "Printing pesanan SGK-001 dimulai",
        "user": "Mesin Epson L1800",
        "time": "10:30",
      },
      {
        "icon": Icons.fact_check_rounded,
        "color": Colors.blue,
        "title": "QC pesanan SGK-002 selesai",
        "user": "Budi Santoso",
        "time": "11:20",
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
            "AKTIVITAS PRODUKSI",
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
              itemCount: activities.length,
              separatorBuilder: (_, _) => const Divider(color: Colors.white10),
              itemBuilder: (context, index) {
                final item = activities[index];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Timeline
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: (item["color"] as Color).withValues(
                            alpha: .18,
                          ),
                          child: Icon(
                            item["icon"] as IconData,
                            color: item["color"] as Color,
                            size: 18,
                          ),
                        ),

                        if (index != activities.length - 1)
                          Container(
                            width: 2,
                            height: 45,
                            color: Colors.white12,
                          ),
                      ],
                    ),

                    const SizedBox(width: 15),

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
                            "Oleh ${item["user"]}",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      item["time"] as String,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
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
      border: Border.all(color: Colors.cyan.withValues(alpha: .2)),
    );
  }
}

