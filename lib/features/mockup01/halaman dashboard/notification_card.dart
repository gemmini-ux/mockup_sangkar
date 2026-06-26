import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      (
        icon: Icons.check_circle_rounded,
        title: "Template Murai Borneo berhasil disimpan",
        subtitle: "Kode : TMP-001",
        color: Colors.green,
        time: "2 menit lalu",
      ),
      (
        icon: Icons.print_rounded,
        title: "Printing SGK-023 selesai",
        subtitle: "Printer Epson L1800",
        color: Colors.cyan,
        time: "12 menit lalu",
      ),
      (
        icon: Icons.content_cut_rounded,
        title: "Cutting decal dimulai",
        subtitle: "Mesin Cutting Plotter",
        color: Colors.orange,
        time: "20 menit lalu",
      ),
      (
        icon: Icons.fact_check_rounded,
        title: "QC pesanan selesai",
        subtitle: "SGK-021",
        color: Colors.purpleAccent,
        time: "1 jam lalu",
      ),
      (
        icon: Icons.backup_rounded,
        title: "Backup database berhasil",
        subtitle: "Cloud Storage",
        color: Colors.blue,
        time: "3 jam lalu",
      ),
    ];

    return Container(
      height: 340,
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "NOTIFIKASI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.notifications_active, color: Colors.cyanAccent),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, _) => const Divider(color: Colors.white10),
              itemBuilder: (context, index) {
                final item = notifications[index];

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: item.color.withValues(alpha: .15),
                    child: Icon(item.icon, color: item.color),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${item.subtitle} • ${item.time}",
                    style: const TextStyle(color: Colors.white54),
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
      border: Border.all(color: Colors.cyan.withValues(alpha: .18)),
    );
  }
}
