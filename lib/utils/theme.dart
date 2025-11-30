import 'package:flutter/material.dart';

class AppTheme {
  static const Color rougeFonce = Color(0xFFA81D8C);
  static const Color dore = Color(0x51ED66D2);

  static const LinearGradient fondDegrade = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
  Color(0x1BFFFFFF), // rouge discret (15% opacité)
  Color(0x1BED66D2), // doré discret
  ],
  );

  static BoxDecoration get background => const BoxDecoration(
  gradient: fondDegrade,
  );

  static ButtonStyle get boutonPrincipal => ElevatedButton.styleFrom(
  backgroundColor: rougeFonce,
  foregroundColor: Colors.white,
  minimumSize: const Size(double.infinity, 48),
  );

  static AppBar appBar(String titre) => AppBar(
  title: Text(titre),
  backgroundColor: rougeFonce,
  foregroundColor: Colors.white,
  );
}
