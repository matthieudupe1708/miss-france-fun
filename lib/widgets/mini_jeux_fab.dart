import 'package:flutter/material.dart';
import '../pages/mini_jeux_hub.dart';

class MiniJeuxButton extends StatelessWidget {
  const MiniJeuxButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.videogame_asset, color: Colors.white),
      tooltip: "Mini-jeux",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MiniJeuxHubPage()),
        );
      },
    );
  }
}
