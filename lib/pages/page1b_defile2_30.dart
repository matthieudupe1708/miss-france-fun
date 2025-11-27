import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../models/joueur_data.dart';
import '../widgets/miss_card.dart';
import '../widgets/mini_jeux_fab.dart';
import 'page2_select15.dart';

class Page1bDefile2_30 extends StatefulWidget {
  final List<Miss> misses30;
  final JoueurData joueurData;
  const Page1bDefile2_30({super.key, required this.misses30, required this.joueurData});

  @override
  State<Page1bDefile2_30> createState() => _Page1bDefile2_30State();
}

class _Page1bDefile2_30State extends State<Page1bDefile2_30> {
  int currentIndex = 0;

  void _prev() { if (currentIndex > 0) setState(() => currentIndex--); }
  void _next() { if (currentIndex < widget.misses30.length - 1) setState(() => currentIndex++); }

  @override
  Widget build(BuildContext context) {
    final miss = widget.misses30[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("2ᵉ défilé – 30 Miss"), actions: const [MiniJeuxButton(),],),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            MissCard(
              miss: miss,
              onChanged: () => setState(() {}),
              currentIndex: currentIndex,
              totalMisses: widget.misses30.length,
              onSelectMiss: (i) => setState(() => currentIndex = i),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: _prev, child: const Text("<")),
                ElevatedButton(onPressed: _next, child: const Text(">")),
              ],
            ),
            if (currentIndex == widget.misses30.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // on part maintenant vers la sélection des 15
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Page2Select15(
                          allMisses: widget.misses30,
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
