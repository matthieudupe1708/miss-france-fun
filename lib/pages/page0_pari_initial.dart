import 'package:flutter/material.dart';
import '../models/miss.dart';
import '../utils/regions.dart';
import '../models/joueur_data.dart';
import 'page1_30miss.dart';

class Page0PariInitial extends StatefulWidget {
  const Page0PariInitial({super.key});

  @override
  State<Page0PariInitial> createState() => _Page0PariInitialState();
}

class _Page0PariInitialState extends State<Page0PariInitial> {
  String? selectedRegion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Étape 0 – Pari initial")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Choisis ta Miss favorite avant le début du concours :",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedRegion,
              decoration: const InputDecoration(
                labelText: "Région",
                border: OutlineInputBorder(),
              ),
              items: regions
                  .map((r) =>
                  DropdownMenuItem(value: r, child: Text("Miss $r")))
                  .toList(),
              onChanged: (val) => setState(() => selectedRegion = val),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedRegion == null
                  ? null
                  : () {
                // Génération initiale des 40 Miss
                final allMisses = List.generate(
                  regions.length,
                      (i) => Miss(
                    id: i + 1,
                    region: regions[i],
                    photoUrl:
                    "assets/miss_photos/${regions[i].toLowerCase().replaceAll(' ', '_').replaceAll('\'', '_').replaceAll('-', '_').replaceAll('é', 'e').replaceAll('ô', 'o').replaceAll('î', 'i')}.jpg",
                  ),
                );

                final joueur = JoueurData(
                  missPariee: selectedRegion!,
                  classement40: [],
                  classement15: [],
                  classement5: [],
                  classementOfficiel: [],
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Page1QuaranteMiss(
                      joueurData: joueur,
                      allMisses: allMisses,
                    ),
                  ),
                );
              },
              child: const Text("Commencer le concours"),
            ),
          ],
        ),
      ),
    );
  }
}
