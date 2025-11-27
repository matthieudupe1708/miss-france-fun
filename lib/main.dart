import 'package:flutter/material.dart';
import 'pages/page0_pari_initial.dart';

void main() {
  runApp(const MissFranceFunApp());
}

class MissFranceFunApp extends StatelessWidget {
  const MissFranceFunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miss France Fun',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 🎨 Couleurs principales
        primaryColor: const Color(0xFF8B0000), // rouge foncé
        scaffoldBackgroundColor: const Color(0xFFFFF8E1), // doré clair
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B0000),
          primary: const Color(0xFF8B0000), // rouge foncé
          secondary: const Color(0xFFFFD700), // doré
        ),

        // 🧱 AppBar uniforme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 2,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // 🟥 Boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B0000), // rouge foncé
            foregroundColor: const Color(0xFFFFD700), // doré
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),

        // 🖋️ Textes
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xFF8B0000), // rouge foncé
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            color: Color(0xFF8B0000),
            fontWeight: FontWeight.bold,
          ),
        ),

        // 🧾 Champs de texte (Dropdown / FormField)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(color: Color(0xFF8B0000)),
        ),
      ),

      // 🏁 Page d’accueil
      home: const Page0PariInitial(),
    );
  }
}
