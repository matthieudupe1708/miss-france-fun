import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../utils/theme.dart';
import 'page3_15miss.dart';
import '../widgets/mini_jeux_fab.dart';

class Page2Select15 extends StatefulWidget {
  final List<Miss> allMisses;     // les 40 Miss notées à l'étape 1
  final JoueurData joueurData;

  const Page2Select15({
    super.key,
    required this.allMisses,
    required this.joueurData,
  });

  @override
  State<Page2Select15> createState() => _Page2Select15State();
}

class _Page2Select15State extends State<Page2Select15> {
  final List<int> selectedIds = [];

  void toggleSelect(Miss miss) {
    setState(() {
      if (selectedIds.contains(miss.id)) {
        selectedIds.remove(miss.id);
      } else if (selectedIds.length < 15) {
        selectedIds.add(miss.id);
      }
    });
  }

  void _goNext() {
    final selectedMisses = widget.allMisses
        .where((m) => selectedIds.contains(m.id))
        .toList();

    // ✅ Remise à zéro des notes pour le nouveau tour (40 -> 15)
    for (var miss in selectedMisses) {
      miss.noteElegance = 0;
      miss.notePrestance = 0;
      miss.noteOriginalite = 0;
    }

    // Sauvegarde du top 15 du joueur (ordre ici = ordre de sélection, tu peux changer)
    widget.joueurData.classement15 = selectedMisses;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Page3QuinzeMiss(
          selectedMisses: selectedMisses,
          joueurData: widget.joueurData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final misses = widget.allMisses;

    return Scaffold(
      appBar: AppBar(title: const Text("Sélection des 15 demi-finalistes"), actions: const [MiniJeuxButton(),],),
      body: Container(
        decoration: AppTheme.background,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Sélectionne 15 Miss :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                ),
                itemCount: misses.length,
                itemBuilder: (context, index) {
                  final miss = misses[index];
                  final isSelected = selectedIds.contains(miss.id);

                  return GestureDetector(
                    onTap: () => toggleSelect(miss),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.rougeFonce
                                  : Colors.grey[300]!,
                              width: isSelected ? 3 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: Image.asset(
                                    miss.photoUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  miss.region,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(Icons.check_circle,
                                color: AppTheme.rougeFonce),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: selectedIds.length == 15 ? _goNext : null,
                child: Text(
                    "Continuer (${selectedIds.length}/15 sélectionnées)"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
