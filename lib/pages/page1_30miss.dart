import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/miss_card.dart';
import '../utils/theme.dart';
import 'page1a_tenues_30.dart';
import '../widgets/mini_jeux_fab.dart';

class Page1QuaranteMiss extends StatefulWidget {
  final JoueurData joueurData;
  final List<Miss> allMisses;

  const Page1QuaranteMiss({
    super.key,
    required this.joueurData,
    required this.allMisses,
  });

  @override
  State<Page1QuaranteMiss> createState() => _Page1QuaranteMissState();
}

class _Page1QuaranteMissState extends State<Page1QuaranteMiss> {
  late List<Miss> missList;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    missList = widget.allMisses;
  }

  void _onChanged() => setState(() {});
  void _prevMiss() {
    if (currentIndex > 0) setState(() => currentIndex--);
  }

  void _nextMiss() {
    if (currentIndex < missList.length - 1) setState(() => currentIndex++);
  }

  @override
  Widget build(BuildContext context) {
    final Miss currentMiss = missList[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Présentation des 30 Miss"), actions: const [MiniJeuxButton(),],),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ta favorite : Miss ${widget.joueurData.missPariee}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.rougeFonce,
              ),
            ),
            const SizedBox(height: 12),
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
                if (value != null) setState(() => currentIndex = value);
              },
            ),
            const SizedBox(height: 12),

            MissCard(
              miss: currentMiss,
              onChanged: _onChanged,
              currentIndex: currentIndex,
              totalMisses: missList.length,
              onSelectMiss: (i) => setState(() => currentIndex = i),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _prevMiss,
                  child: const Text("<"),
                ),
                ElevatedButton(
                  onPressed: _nextMiss,
                  child: const Text(">"),
                ),
              ],
            ),

            if (currentIndex == missList.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Enregistrer le classement complet de cette étape
                    widget.joueurData.classement40 = missList;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        /* builder: (_) => Page2Select15( */
                        builder: (_) => Page1aTenues30(
                          misses30: missList,
                          joueurData: widget.joueurData,
                        ),
                      ),
                    );
                  },
                  child: const Text("Valider et continuer"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
