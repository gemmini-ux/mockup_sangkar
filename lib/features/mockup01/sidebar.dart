import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = [
      (Icons.dashboard_outlined, "Dashboard"),
      (Icons.grid_view_rounded, "Template"),
      (Icons.draw_outlined, "Desain"),
      (Icons.palette_outlined, "Tema & Style"),
      (Icons.auto_awesome_outlined, "Ornamen"),
      (Icons.extension_outlined, "Komponen"),
      (Icons.smart_toy_outlined, "AI Prompt"),
      (Icons.map_outlined, "Mapping Editor"),
      (Icons.view_in_ar_outlined, "Preview 3D"),
      (Icons.precision_manufacturing_outlined, "Produksi"),
      (Icons.shopping_cart_outlined, "Pesanan"),
      (Icons.people_outline, "Pelanggan"),
      (Icons.bar_chart_outlined, "Laporan"),
      (Icons.settings_outlined, "Pengaturan"),
    ];

    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: Color(0xff07101F),
        border: Border(right: BorderSide(color: Color(0xff16253C))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),

          /// LOGO
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xff101B2D),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.cyanAccent,
                  child: Icon(Icons.auto_fix_high, color: Colors.black),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SANGKAR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Designer Studio",
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final item = menus[index];

                final selected = index == 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.cyan.withValues(alpha: .15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      item.$1,
                      size: 20,
                      color: selected ? Colors.cyanAccent : Colors.white70,
                    ),
                    title: Text(
                      item.$2,
                      style: TextStyle(
                        color: selected ? Colors.cyanAccent : Colors.white70,
                        fontSize: 12,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                    trailing: selected
                        ? const Icon(
                            Icons.chevron_right,
                            color: Colors.cyanAccent,
                            size: 18,
                          )
                        : null,
                    onTap: () {},
                  ),
                );
              },
            ),
          ),

          const Divider(color: Colors.white12, height: 1),

          Container(
            padding: const EdgeInsets.all(18),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.cyanAccent,
                  child: Icon(Icons.person, color: Colors.black),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin Produksi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Professional Edition",
                        style: TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

