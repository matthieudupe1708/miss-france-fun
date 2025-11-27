import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/miss_card.dart';
import '../utils/theme.dart';
import 'page5a_questions_5.dart';
import '../widgets/mini_jeux_fab.dart';

class Page5CinqMiss extends StatefulWidget {
  final List<Miss> selectedMisses; // les 5 finalistes
  final JoueurData joueurData;

  const Page5CinqMiss({
    super.key,
    required this.selectedMisses,
    required this.joueurData,
  });

  @override
  State<Page5CinqMiss> createState() => _Page5CinqMissState();
}

class _Page5CinqMissState extends State<Page5CinqMiss> {
  late List<Miss> missList;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    missList = widget.selectedMisses;
  }

  void _onChanged() => setState(() {});
  void _prevMiss() { if (currentIndex > 0) setState(() => currentIndex--); }
  void _nextMiss() { if (currentIndex < missList.length - 1) setState(() => currentIndex++); }

  void _goNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        /* builder: (_) => Page5bClassement( */
        builder: (_) => Page5aQuestions5(
          finalMisses: missList,
          joueurData: widget.joueurData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Miss currentMiss = missList[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Évaluation des 5 finalistes"), actions: const [MiniJeuxButton(),],),
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
