import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';   // <-- AJOUT
import '../utils/theme.dart';
import 'mini_jeu_bingo.dart';
import 'mini_jeu_dessin.dart';

class MiniJeuxHubPage extends StatelessWidget {
  const MiniJeuxHubPage({super.key});

  // ---- Fonction pour ouvrir un lien externe ----
  Future<void> openExternalUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception("Impossible d'ouvrir $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini-jeux Miss France"),
        centerTitle: true,
      ),
      body: Container(
        decoration: AppTheme.background,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Choisis un mini-jeu pour t'occuper pendant les pubs :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // --- BINGO ---
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.grid_on),
                title: const Text("Bingo des discours"),
                subtitle: const Text(
                    "Coche les tics de langage, les phrases typiques, etc."),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MiniJeuBingoDiscours(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // --- DESSIN ---
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.brush),
                title: const Text("Dessiner Miss France"),
                subtitle: const Text(
                    "Un carnet de dessin pour imaginer ta Miss France idéale."),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MiniJeuDessinerMissFrance(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // --- MINI-JEU WEB 1 ---
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.public),
                title: const Text("Quiz Miss France 2026 – Partie 1"),
                subtitle: const Text("CultureQuizz – spécial Miss France"),
                onTap: () {
                  openExternalUrl("https://www.culturequizz.com/quiz/quiz-culture-miss-france-2026-partie-1/",);
                },
              ),
            ),
            const SizedBox(height: 12),

            // --- MINI-JEU WEB 2 ---
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.public_outlined),
                title: const Text("Quiz Miss France 2026 – Partie 2"),
                subtitle: const Text("CultureQuizz – spécial Miss France"),
                onTap: () {
                  openExternalUrl("https://www.culturequizz.com/quiz/quiz-culture-miss-france-2026-partie-2/");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
