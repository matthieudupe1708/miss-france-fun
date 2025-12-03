import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/miss_card.dart';
import '../utils/theme.dart';
import '../widgets/mini_jeux_fab.dart';
import 'page2_select15.dart';

class Page1bDefile2_30 extends StatefulWidget {
  final List<Miss> misses30;
  final JoueurData joueurData;

  const Page1bDefile2_30({
    super.key,
    required this.misses30,
    required this.joueurData,
  });

  @override
  State<Page1bDefile2_30> createState() => _Page1bDefile2_30State();
}

class _Page1bDefile2_30State extends State<Page1bDefile2_30> {
  late List<Miss> missList;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // On travaille toujours sur la même liste que celle passée depuis les pages précédentes
    missList = widget.misses30;
  }

  void _prev() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  void _next() {
    if (currentIndex < missList.length - 1) {
      setState(() => currentIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final miss = missList[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("2ᵉ défilé – 30 Miss"),
        centerTitle: true,
        actions: const [
          MiniJeuxButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Rappel de la favorite
            Text(
              "Ta favorite : Miss ${widget.joueurData.missPariee}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.rougeFonce,
              ),
            ),

            const SizedBox(height: 12),

            // 🔽 Liste déroulante pour choisir directement une Miss
            DropdownButtonFormField<int>(
              value: currentIndex,
              decoration: const InputDecoration(
                labelText: "Choisis la Miss à noter",
                border: OutlineInputBorder(),
              ),
              items: List.generate(missList.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text("Miss ${missList[index].region}"),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  setState(() => currentIndex = value);
                }
              },
            ),

            const SizedBox(height: 12),

            // Carte de notation (défilé 2)
            MissCard(
              miss: miss,
              onChanged: () => setState(() {}),
              currentIndex: currentIndex,
              totalMisses: missList.length,
              onSelectMiss: (i) => setState(() => currentIndex = i),
            ),

            const SizedBox(height: 12),

            // Boutons précédent / suivant
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _prev,
                  child: const Text("<"),
                ),
                ElevatedButton(
                  onPressed: _next,
                  child: const Text(">"),
                ),
              ],
            ),

            // Bouton de validation quand on est sur la dernière Miss
            if (currentIndex == missList.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Page2Select15(
                          allMisses: missList,
                          joueurData: widget.joueurData,
                        ),
                      ),
                    );
                  },
                  child: const Text("Sélectionner les 15"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
