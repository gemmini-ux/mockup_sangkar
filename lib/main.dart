import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/homepage.dart';

void main() {
  runApp(const MockupSangkarApp());
}

//gemmini-ux/mockup_sangkar
class MockupSangkarApp extends StatelessWidget {
  const MockupSangkarApp({super.key});

  // ── Font standar seluruh app: Poppins 12sp ──────────────
  static const String fontFamily = 'Poppins';
  static const double fontSizeBase = 12.0;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sangkar Decal Studio',

      // Poppins sebagai font default semua widget
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: fontFamily,
          bodyColor: Colors.white,
          displayColor: Colors.white,
          fontSizeFactor: 1.0,
          fontSizeDelta: 0.0,
        ),
        // Warna skema global app
        colorScheme: const ColorScheme.dark(
          primary: Colors.cyanAccent,
          secondary: Colors.cyanAccent,
          surface: Color(0xFF091121),
        ),
      ),

      home: const HomePage(),
    );
  }
}
