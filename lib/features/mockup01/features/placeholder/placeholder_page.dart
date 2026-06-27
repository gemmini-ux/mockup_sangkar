import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF091121),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Icon(
            Icons.construction_rounded,
            size: 64,
            color: Colors.cyanAccent.withValues(alpha: 0.8),
          ),
          const SizedBox(height: 16),
          // Header / Title: size 20 (can be larger adjusting to the screen)
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          // Body/Description: size 12
          const Text(
            'Modul draf ini telah terintegrasi dalam sistem Sangkar Decal Production.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          // Additional Info/Caption: size 10 (below 12)
          const Text(
            'Seluruh fungsionalitas visual backend & local database terhubung.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white38,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

