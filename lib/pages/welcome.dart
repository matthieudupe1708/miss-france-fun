import 'package:flutter/material.dart';
import '../utils/theme.dart';
import 'page0_pari_initial.dart';

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Miss France Fun"),
        centerTitle: true,
        actions: const [],
      ),
      body: Container(
        decoration: AppTheme.background,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🖼️ Une seule photo
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/accueil_miss.jpg",  // 👉 Ton image ici
                width: MediaQuery.of(context).size.width * 0.9,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Bienvenue dans Miss France Fun !\n"
                    "Note les Miss, fais tes pronostics et amuse-toi pendant l'émission 🎉",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.rougeFonce,
                ),
              ),
            ),

            const Spacer(),

            // Bouton Commencer
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Page0PariInitial(),
                        ),
                      );
                    },
                    child: const Text(
                      "Commencer le jeu",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
