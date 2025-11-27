import 'package:flutter/material.dart';
import '../models/joueur_data.dart';
import '../models/miss.dart';
import '../utils/theme.dart';
import '../utils/calcul_score.dart';
import '../widgets/mini_jeux_fab.dart';

class Page6Resultats extends StatefulWidget {
  final JoueurData joueurData;
  const Page6Resultats({super.key, required this.joueurData});

  @override
  State<Page6Resultats> createState() => _Page6ResultatsState();
}

class _Page6ResultatsState extends State<Page6Resultats> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    final calcul = CalculScore();
    final details = calcul.detail(widget.joueurData);
    final total = details['total'] ?? 0;
    final classement = widget.joueurData.classementOfficiel;

    final Miss missFrance = classement.isNotEmpty
        ? classement.last
        : Miss(id: 0, region: "Inconnue", photoUrl: "", noteElegance: 0, notePrestance: 0, noteOriginalite: 0);

    return Scaffold(
      appBar: AppBar(title: const Text("Résultats finaux"), centerTitle: true, actions: const [MiniJeuxButton(),],),
      body: Container(
        decoration: AppTheme.background,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Classement officiel",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.rougeFonce,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // --- Miss France en grand ---
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: missFrance.photoUrl.isNotEmpty
                    ? Image.asset(
                  missFrance.photoUrl,
                  height: 220,
                  fit: BoxFit.cover,
                )
                    : Container(
                  height: 220,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text("📸 Photo indisponible"),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "👑 Miss France 2025 : ${missFrance.region}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.rougeFonce,
                ),
              ),
              const SizedBox(height: 25),

              // --- Classement complet ---
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: classement.length,
                itemBuilder: (context, index) {
                  final miss = classement[classement.length - 1 - index];
                  final position = index == 0
                      ? "👑 Miss France"
                      : "${index}ᵉ dauphine";
                  return Card(
                    margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(miss.photoUrl),
                      ),
                      title: Text("Miss ${miss.region}"),
                      subtitle: Text(position),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // --- Score global ---
              const Text(
                "Score final du joueur",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.rougeFonce),
              ),
              const SizedBox(height: 8),
              Text(
                "$total / 120 points",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.rougeFonce,
                  backgroundColor: AppTheme.dore,
                ),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () => setState(() => showDetails = !showDetails),
                child: Text(
                  showDetails
                      ? "Masquer les détails"
                      : "Voir les détails du score",
                ),
              ),

              if (showDetails) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.rougeFonce, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🎯 Pari Miss favorite : ${details['pari']} pts"),
                      Text("💃 Top 15 : ${details['top15']} pts"),
                      Text("👑 Top 5 : ${details['top5']} pts"),
                      Text("🏆 Classement final : ${details['finale']} pts"),
                      Text("🎓 Cohérence : ${details['coherence']} pts"),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () => Navigator.popUntil(
                    context, (route) => route.isFirst),
                child: const Text("Rejouer le concours"),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
