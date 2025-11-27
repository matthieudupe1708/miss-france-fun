import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../utils/theme.dart';
import 'page6_resultats.dart';
import '../widgets/mini_jeux_fab.dart';

class Page5bClassement extends StatefulWidget {
  final List<Miss> finalMisses;
  final JoueurData joueurData;
  const Page5bClassement({
    super.key,
    required this.finalMisses,
    required this.joueurData,
  });

  @override
  State<Page5bClassement> createState() => _Page5bClassementState();
}

class _Page5bClassementState extends State<Page5bClassement> {
  final List<Miss> classement = [];

  void addToClassement(Miss miss) {
    if (!classement.contains(miss)) {
      setState(() => classement.add(miss));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Classement final officiel"), actions: const [MiniJeuxButton(),],),
      body: Container(
        decoration: AppTheme.background,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Sélectionne les Miss dans l’ordre du classement (5e → Miss France)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: widget.finalMisses.length,
                itemBuilder: (context, index) {
                  final miss = widget.finalMisses[index];
                  final isSelected = classement.contains(miss);
                  return GestureDetector(
                    onTap: () => addToClassement(miss),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.dore
                              : Colors.grey[300]!,
                          width: isSelected ? 3 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.asset(
                                miss.photoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              "Miss ${miss.region}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: classement.length == widget.finalMisses.length
                  ? () {
                widget.joueurData.classementOfficiel = classement;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        Page6Resultats(joueurData: widget.joueurData),
                  ),
                );
              }
                  : null,
              child: const Text("Valider le classement"),
            ),
          ],
        ),
      ),
    );
  }
}
