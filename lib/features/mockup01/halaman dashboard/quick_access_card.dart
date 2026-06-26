import 'package:flutter/material.dart';

class QuickAccessCard extends StatelessWidget {
  const QuickAccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.shopping_cart_checkout,
        title: "Pesanan",
        color: Colors.cyan,
      ),
      (
        icon: Icons.precision_manufacturing,
        title: "Produksi",
        color: Colors.purple,
      ),
      (icon: Icons.inventory_2_outlined, title: "Stok", color: Colors.orange),
      (icon: Icons.palette_outlined, title: "Decal", color: Colors.green),
      (
        icon: Icons.architecture_outlined,
        title: "Model",
        color: Colors.pinkAccent,
      ),
      (icon: Icons.fact_check_outlined, title: "QC", color: Colors.amber),
      (
        icon: Icons.local_shipping_outlined,
        title: "Pengiriman",
        color: Colors.blue,
      ),
      (icon: Icons.people_outline, title: "Pelanggan", color: Colors.redAccent),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "AKSES CEPAT",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: items.map((item) {
              return SizedBox(
                width: 145,
                height: 120,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .03),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: item.color.withValues(alpha: .30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, color: item.color, size: 34),

                        const SizedBox(height: 12),

                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
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
