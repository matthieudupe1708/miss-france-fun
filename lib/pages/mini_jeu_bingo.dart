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
    _BingoCase("Une chute des plus classe"),
    _BingoCase("Je veux \"faire découvrir mon île au français\""),
    _BingoCase("Une miss fait un coeur avec les mains"),
    _BingoCase("Cri de guerre des miss pendant le voyage"),
    _BingoCase("Problème d'écharpe pendant le défilé"),
    _BingoCase("\"Bonsoir la France\""),
    _BingoCase("C'est un rêve de petite fille"),
    _BingoCase("1 an d'abonnement à Télé-Loisir"),
    _BingoCase("Miss cheveux court"),
    _BingoCase("Une femme engagée et indépendante"),
    _BingoCase("Une cause qui me tient à coeur"),
    _BingoCase("\"Tout le monde peut devenir miss France\""),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Cases cochées : $cochees / ${cases.length}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // 🔥 GRILLE 3 COLONNES
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,         // 👈 3 colonnes
                  childAspectRatio: 0.85,    // 👈 format compact et équilibré
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
                              : Colors.grey.withOpacity(0.4),
                          width: 2,
                        ),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            c.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.5,
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

            // Bouton reset
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
