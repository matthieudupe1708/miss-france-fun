import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/miss_card.dart';
import '../utils/theme.dart';
import 'page4_select5.dart';
import '../widgets/mini_jeux_fab.dart'; // Ton import actuel

class Page3QuinzeMiss extends StatefulWidget {
  final List<Miss> selectedMisses; // les 15 demi-finalistes
  final JoueurData joueurData;

  const Page3QuinzeMiss({
    super.key,
    required this.selectedMisses,
    required this.joueurData,
  });

  @override
  State<Page3QuinzeMiss> createState() => _Page3QuinzeMissState();
}

class _Page3QuinzeMissState extends State<Page3QuinzeMiss> {
  late List<Miss> missList;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    missList = widget.selectedMisses; // mêmes instances qu’avant
  }

  void _onChanged() => setState(() {});
  void _prevMiss() { if (currentIndex > 0) setState(() => currentIndex--); }
  void _nextMiss() { if (currentIndex < missList.length - 1) setState(() => currentIndex++); }

  void _goNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Page4Select5(
          selectedMisses: missList,
          joueurData: widget.joueurData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Miss currentMiss = missList[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Évaluation des 15 demi-finalistes"),
        centerTitle: true,
        actions: const [
          MiniJeuxButton(), // reste ton nom de fichier actuel
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

            // 🔽 DROPDOWN POUR CHOISIR UNE MISS DIRECTEMENT
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

            // 🔥 MISS CARD
            MissCard(
              miss: currentMiss,
              onChanged: _onChanged,
              currentIndex: currentIndex,
              totalMisses: missList.length,
              onSelectMiss: (i) => setState(() => currentIndex = i),
            ),

            const SizedBox(height: 12),

            // Navigation précédente / suivante
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: _prevMiss, child: const Text("<")),
                ElevatedButton(onPressed: _nextMiss, child: const Text(">")),
              ],
            ),

            // Bouton de validation à la fin
            if (currentIndex == missList.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: _goNext,
                  child: const Text("Valider et continuer"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
