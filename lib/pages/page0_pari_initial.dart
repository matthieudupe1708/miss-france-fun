import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/regions.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/mini_jeux_fab.dart';
import 'page1_30miss.dart';   // ton fichier de présentation des 30

class Page0PariInitial extends StatelessWidget {
  const Page0PariInitial({super.key});

  List<Miss> _buildMissList() {
    final selectedRegions = regions.length > 30 ? regions.sublist(0, 30) : regions;

    return List.generate(
      selectedRegions.length,
          (i) => Miss(
        id: i + 1,
        region: selectedRegions[i],
        photoUrl:
        "assets/miss_photos/${selectedRegions[i].toLowerCase()
            .replaceAll(' ', '_')
            .replaceAll('\'', '_')
            .replaceAll('-', '_')
            .replaceAll('é', 'e')
            .replaceAll('è', 'e')
            .replaceAll('ê', 'e')
            .replaceAll('ô', 'o')
            .replaceAll('î', 'i')}.jpg",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final missList = _buildMissList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choisis ta Miss favorite"),
        centerTitle: true,
        actions: const [
          MiniJeuxButton(),
        ],
      ),
      body: Container(
        decoration: AppTheme.background,
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Clique sur la photo de la Miss que tu pronostiques gagnante !",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.rougeFonce,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 10),

            // ------------------------------
            // 🔥 Grille de photos des Miss
            // ------------------------------
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,      // 3 photos par ligne
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.72, // format portrait
                ),
                itemCount: missList.length,
                itemBuilder: (context, index) {
                  final miss = missList[index];

                  return GestureDetector(
                    onTap: () {
                      // → Création du JoueurData
                      final joueur = JoueurData(
                        missPariee: miss.region,
                        classement40: [],
                        classement15: [],
                        classement5: [],
                        classementOfficiel: [],
                      );

                      // → Navigation vers la Page 1
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Page1QuaranteMiss(
                            joueurData: joueur,
                            allMisses: missList,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              miss.photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[300],
                                alignment: Alignment.center,
                                child: Text(
                                  "Miss\n${miss.region}",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          miss.region,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.rougeFonce,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
