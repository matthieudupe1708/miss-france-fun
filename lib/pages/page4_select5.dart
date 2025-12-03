import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../utils/theme.dart';
import 'page5_5miss.dart';
import '../widgets/mini_jeux_fab.dart';

class Page4Select5 extends StatefulWidget {
  final List<Miss> selectedMisses; // les 15 notées
  final JoueurData joueurData;

  const Page4Select5({
    super.key,
    required this.selectedMisses,
    required this.joueurData,
  });

  @override
  State<Page4Select5> createState() => _Page4Select5State();
}

class _Page4Select5State extends State<Page4Select5> {
  final List<int> selectedIds = [];

  void toggleSelect(Miss miss) {
    setState(() {
      if (selectedIds.contains(miss.id)) {
        selectedIds.remove(miss.id);
      } else if (selectedIds.length < 5) {
        selectedIds.add(miss.id);
      }
    });
  }

  void _goNext() {
    final selectedMisses = widget.selectedMisses
        .where((m) => selectedIds.contains(m.id))
        .toList();

    // ✅ Remise à zéro des notes pour le nouveau tour (15 -> 5)
    for (var miss in selectedMisses) {
      miss.noteElegance = 0;
      miss.notePrestance = 0;
      miss.noteOriginalite = 0;
    }

    // Sauvegarde du top 5 du joueur
    widget.joueurData.classement5 = selectedMisses;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Page5CinqMiss(
          selectedMisses: selectedMisses,
          joueurData: widget.joueurData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final misses = widget.selectedMisses;

    return Scaffold(
      appBar: AppBar(title: const Text("Sélection des 5 finalistes"), actions: const [MiniJeuxButton(),],),
      body: Container(
        decoration: AppTheme.background,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Sélectionne les 5 finalistes :",
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
                                  : Color(0xED66D2),
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
                onPressed: selectedIds.length == 5 ? _goNext : null,
                child:
                Text("Continuer (${selectedIds.length}/5 sélectionnées)"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
