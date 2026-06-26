import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF091121),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: .45)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .10),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withValues(alpha: .30)),
                ),
                child: Icon(icon, color: color, size: 16),
              ),

              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// VALUE
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),

          const SizedBox(height: 8),

          /// FOOTER
          Row(
            children: [
              Icon(Icons.arrow_upward, size: 12, color: color),

              const SizedBox(width: 3),

              Text(
                "18%",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),

              const SizedBox(width: 3),

              const Expanded(
                child: Text(
                  "vs bulan lalu",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ),

              SizedBox(
                width: 45,
                height: 16,
                child: CustomPaint(painter: _SparkPainter(color)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  final Color color;

  _SparkPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height - 2)
      ..lineTo(7, size.height - 4)
      ..lineTo(14, size.height - 3)
      ..lineTo(21, size.height - 7)
      ..lineTo(28, size.height - 5)
      ..lineTo(35, size.height - 10)
      ..lineTo(42, 4)
      ..lineTo(size.width, 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
