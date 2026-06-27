import 'package:flutter/material.dart';

class DonutChartCard extends StatelessWidget {
  const DonutChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "STATUS PRODUKSI",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: .82,
                      strokeWidth: 16,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation(
                        Colors.greenAccent,
                      ),
                    ),
                  ),

                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "82%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("Selesai", style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LegendItem(color: Colors.green, title: "Selesai", value: "82"),
              LegendItem(color: Colors.orange, title: "Produksi", value: "21"),
              LegendItem(color: Colors.redAccent, title: "Revisi", value: "7"),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: const Color(0xFF091121),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.cyan.withValues(alpha: .18)),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String title;
  final String value;

  const LegendItem({
    super.key,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            Text(
              value,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

