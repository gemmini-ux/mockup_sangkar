import 'package:flutter/material.dart';

class MockupTheme {
  static Color accentColor = Colors.cyanAccent;
  static Color cardColor = const Color(0xFF101B2D);
  static Color backgroundColor = const Color(0xFF0C0A19);
  
  static void setTheme({
    required Color accent,
    required Color card,
    required Color background,
  }) {
    accentColor = accent;
    cardColor = card;
    backgroundColor = background;
  }
  
  static void reset() {
    accentColor = Colors.cyanAccent;
    cardColor = const Color(0xFF101B2D);
    backgroundColor = const Color(0xFF0C0A19);
  }
}
