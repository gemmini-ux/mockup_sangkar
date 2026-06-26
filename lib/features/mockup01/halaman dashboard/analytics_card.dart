import 'package:flutter/material.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TREN PRODUKSI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("7 Hari", style: TextStyle(color: Colors.cyanAccent)),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: CustomPaint(painter: LineChartPainter(), child: Container()),
          ),

          const SizedBox(height: 12),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Sen", style: TextStyle(color: Colors.white54)),
              Text("Sel", style: TextStyle(color: Colors.white54)),
              Text("Rab", style: TextStyle(color: Colors.white54)),
              Text("Kam", style: TextStyle(color: Colors.white54)),
              Text("Jum", style: TextStyle(color: Colors.white54)),
              Text("Sab", style: TextStyle(color: Colors.white54)),
              Text("Min", style: TextStyle(color: Colors.white54)),
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

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height * .75);
    path.quadraticBezierTo(
      size.width * .15,
      size.height * .55,
      size.width * .30,
      size.height * .68,
    );

    path.quadraticBezierTo(
      size.width * .45,
      size.height * .90,
      size.width * .60,
      size.height * .40,
    );

    path.quadraticBezierTo(
      size.width * .75,
      size.height * .15,
      size.width,
      size.height * .28,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
