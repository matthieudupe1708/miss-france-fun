import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme.dart';

class MiniJeuBingoDiscours extends StatefulWidget {
  const MiniJeuBingoDiscours({super.key});

  @override
  State<MiniJeuBingoDiscours> createState() => _MiniJeuBingoDiscoursState();
}

class _MiniJeuBingoDiscoursState extends State<MiniJeuBingoDiscours> {
  static const _prefsKey = 'bingo_discours_states_v1';

  final List<_BingoCase> cases = [
    _BingoCase("Je réalise un rêve de petite fille"),
    _BingoCase("Je veux représenter ma région avec fierté"),
    _BingoCase("Je suis très émue"),
    _BingoCase("Je remercie mes parents"),
    _BingoCase("La sororité entre Miss"),
    _BingoCase("Une femme engagée et moderne"),
    _BingoCase("Je veux défendre une cause qui me tient à cœur"),
    _BingoCase("C’est une incroyable aventure humaine"),
    _BingoCase("Merci au comité Miss France"),
    _BingoCase("Je ne m’y attendais pas du tout"),
    _BingoCase("Je suis très fière de mon parcours"),
    _BingoCase("Je veux inspirer les jeunes filles"),
  ];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKey);
    if (saved != null && saved.length == cases.length) {
      for (int i = 0; i < cases.length; i++) {
        cases[i].checked = saved[i] == '1';
      }
      setState(() {});
    }
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _prefsKey,
      cases.map((c) => c.checked ? '1' : '0').toList(),
    );
  }

  void _toggleCase(int index) {
    setState(() {
      cases[index].checked = !cases[index].checked;
    });
    _saveState();
  }

  void _resetAll() {
    setState(() {
      for (var c in cases) {
        c.checked = false;
      }
    });
    _saveState();
  }

  @override
  Widget build(BuildContext context) {
    final int cochees = cases.where((c) => c.checked).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bingo des discours"),
        centerTitle: true,
      ),
      body: Container(
        decoration: AppTheme.background,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Coche ce que tu entends pendant les discours !",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Cases cochées : $cochees / ${cases.length}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: cases.length,
                itemBuilder: (context, index) {
                  final c = cases[index];
                  return GestureDetector(
                    onTap: () => _toggleCase(index),
                    child: Card(
                      color: c.checked
                          ? AppTheme.rougeFonce.withOpacity(0.85)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: c.checked
                              ? AppTheme.dore
                              : Colors.grey.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            c.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: c.checked ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _resetAll,
                        child: const Text("Tout réinitialiser"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BingoCase {
  final String label;
  bool checked;
  _BingoCase(this.label, {this.checked = false});
}
