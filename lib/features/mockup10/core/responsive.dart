// ============================================================
// RESPONSIVE HELPER — Titik Acuan Breakpoint Layar
// Gunakan class ini di seluruh aplikasi untuk layout adaptif
// ============================================================
//
// Breakpoint:
///   Mobile  : lebar < 600px   (HP)
///
///   Tablet  : 600 – 1024px   (Tablet / iPad)
///   Desktop : > 1024px        (Windows / Laptop)
library;

import 'package:flutter/material.dart';

/// Tiga jenis ukuran layar
enum TipeLayar { mobile, tablet, desktop }

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  // ── Pendeteksi tipe layar ────────────────────────────────
  static bool isMobile(BuildContext ctx) => MediaQuery.sizeOf(ctx).width < 600;

  static bool isTablet(BuildContext ctx) {
    final w = MediaQuery.sizeOf(ctx).width;
    return w >= 600 && w < 1024;
  }

  static bool isDesktop(BuildContext ctx) =>
      MediaQuery.sizeOf(ctx).width >= 1024;

  static TipeLayar tipe(BuildContext ctx) {
    final w = MediaQuery.sizeOf(ctx).width;
    if (w >= 1024) return TipeLayar.desktop;
    if (w >= 600) return TipeLayar.tablet;
    return TipeLayar.mobile;
  }

  /// Padding konten berdasarkan ukuran layar
  static EdgeInsets padding(BuildContext ctx) {
    if (isMobile(ctx)) return const EdgeInsets.all(12);
    if (isTablet(ctx)) return const EdgeInsets.all(16);
    return const EdgeInsets.all(20);
  }

  /// Jumlah kolom grid StatCard
  static int kolomStatCard(BuildContext ctx) {
    if (isMobile(ctx)) return 2;
    if (isTablet(ctx)) return 3;
    return 5;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        if (w >= 1024) return desktop;
        if (w >= 600) return tablet ?? desktop;
        return mobile;
      },
    );
  }
}
