import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/miss_card.dart';
import '../utils/theme.dart';
import '../widgets/mini_jeux_fab.dart';
import 'page1b_defile2_30.dart';

class Page1aTenues30 extends StatefulWidget {
  final List<Miss> misses30;
  final JoueurData joueurData;

  const Page1aTenues30({
    super.key,
    required this.misses30,
    required this.joueurData,
  });

  @override
  State<Page1aTenues30> createState() => _Page1aTenues30State();
}

class _Page1aTenues30State extends State<Page1aTenues30> {
  late List<Miss> missList;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    missList = widget.misses30;

    // Remise à zéro des notes pour cette phase "Tenue traditionnelle"
    for (var m in missList) {
      m.noteElegance = 0;
      // on laisse éventuellement prestance / originalité pour d'autres phases
    }
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
      appBar: AppBar(title: const Text("Tenues traditionnelles – 30 Miss"), actions: const [MiniJeuxButton(),],),
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

          MissCardTenue(
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
                      builder: (_) => Page1bDefile2_30(
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
