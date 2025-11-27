import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/miss_card.dart';
import '../utils/theme.dart';
import 'page4_select5.dart';
import '../widgets/mini_jeux_fab.dart';

class Page3QuinzeMiss extends StatefulWidget {
  final List<Miss> selectedMisses; // les 15 sélectionnées
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
    missList = widget.selectedMisses; // mêmes instances
  }

  void _onChanged() => setState(() {});
  void _prevMiss() { if (currentIndex > 0) setState(() => currentIndex--); }
  void _nextMiss() { if (currentIndex < missList.length - 1) setState(() => currentIndex++); }

  void _goNext() {
    // (optionnel) si tu veux trier par score avant la suite :
    // missList.sort((a, b) => a.totalScore.compareTo(b.totalScore));

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
      appBar: AppBar(title: const Text("Évaluation des 15 demi-finalistes"), actions: const [MiniJeuxButton(),],),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            MissCard(
              miss: currentMiss,
              onChanged: _onChanged,
              currentIndex: currentIndex,
              totalMisses: missList.length,
              onSelectMiss: (i) => setState(() => currentIndex = i),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: _prevMiss, child: const Text("<")),
                ElevatedButton(onPressed: _nextMiss, child: const Text(">")),
              ],
            ),
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
