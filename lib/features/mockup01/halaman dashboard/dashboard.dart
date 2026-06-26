// scaffold
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DASHBOARD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Selamat datang kembali, Andi Setiawan! 👋',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),

        /// RIGHT
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF091121),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.cyanAccent.withValues(alpha: .25)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: Colors.cyanAccent,
                size: 18,
              ),

              SizedBox(width: 10),

              Text(
                '24 Mei 2024',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
