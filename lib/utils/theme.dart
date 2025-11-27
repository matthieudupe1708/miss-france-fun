import 'package:flutter/material.dart';

class AppTheme {
  static const Color rougeFonce = Color(0xFF8B0000);
  static const Color dore = Color(0xFFFFD54F);

  static const LinearGradient fondDegrade = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
  Color(0x26B71C1C), // rouge discret (15% opacité)
  Color(0x26FFD54F), // doré discret
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
