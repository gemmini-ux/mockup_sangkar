import 'package:flutter/material.dart';

class ProductionCard extends StatelessWidget {
  const ProductionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.precision_manufacturing,
                  color: Colors.cyanAccent,
                  size: 16,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  "STATUS PRODUKSI HARI INI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const Center(
            child: Text(
              "120",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Center(
            child: Text(
              "TARGET PRODUKSI",
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ),

          // const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: .78,
              minHeight: 12,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(Colors.cyanAccent),
            ),
          ),

          // const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "94 Unit Selesai",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "78%",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Divider(color: Colors.white12),

          const SizedBox(height: 8),

          const Row(
            children: [
              Expanded(
                child: _InfoItem(title: "QC", value: "8", color: Colors.orange),
              ),

              Expanded(
                child: _InfoItem(
                  title: "Packing",
                  value: "6",
                  color: Colors.purpleAccent,
                ),
              ),

              Expanded(
                child: _InfoItem(
                  title: "Belum",
                  value: "26",
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.cyan.withValues(alpha: .15),
                foregroundColor: Colors.cyanAccent,
              ),
              onPressed: () {},
              icon: const Icon(Icons.factory_outlined),
              label: const Text("Lihat Produksi"),
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
      border: Border.all(color: Colors.cyan.withValues(alpha: .25)),
      boxShadow: [
        BoxShadow(color: Colors.cyan.withValues(alpha: .08), blurRadius: 20),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _InfoItem({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}

