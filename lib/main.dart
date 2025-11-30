import 'package:flutter/material.dart';
import 'pages/welcome.dart';

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
        primaryColor: const Color(0xFFA81D8C), // rouge foncé
        scaffoldBackgroundColor: const Color(0x1BED66D2), // doré clair
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA81D8C),
          primary: const Color(0xFFA81D8C), // rouge foncé
          secondary: const Color(0xFFA81D8C), // doré
        ),

        // 🧱 AppBar uniforme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFA81D8C),
          foregroundColor: Color(0x751010),
          elevation: 2,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),

        // 🟥 Boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA81D8C), // rouge foncé
            foregroundColor: const Color(0xFFFFFFFF), // doré
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
            color: Color(0xFFA81D8C), // rouge foncé
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            color: Color(0x51ED66D2),
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
          labelStyle: const TextStyle(color: Color(0x51ED66D2)),
        ),
      ),

      // 🏁 Page d’accueil
      home: const PageAccueil(),
    );
  }
}
