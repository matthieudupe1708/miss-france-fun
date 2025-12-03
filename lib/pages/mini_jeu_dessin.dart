import 'package:flutter/material.dart';
import '../utils/theme.dart';

class MiniJeuDessinerMissFrance extends StatefulWidget {
  const MiniJeuDessinerMissFrance({super.key});

  @override
  State<MiniJeuDessinerMissFrance> createState() =>
      _MiniJeuDessinerMissFranceState();
}

// Point coloré (position + couleur)
class _ColoredPoint {
  final Offset? offset;
  final Color color;
  _ColoredPoint(this.offset, this.color);
}

class _MiniJeuDessinerMissFranceState
    extends State<MiniJeuDessinerMissFrance> {
  final List<_ColoredPoint> _points = [];

  // Chemin de ton image de base à colorier
  static const String _baseImagePath =
      "assets/mini_jeux/coloriage_miss.png"; // 🔁 adapte le nom si besoin

  // Couleur actuelle
  Color _currentColor = AppTheme.rougeFonce;

  // Palette
  final List<Color> _palette = [
    AppTheme.rougeFonce,
    AppTheme.dore,
    Colors.black,
    Colors.blueAccent,
    Colors.green,
    Colors.purple,
  ];

  void _addPoint(Offset offset) {
    setState(() {
      _points.add(_ColoredPoint(offset, _currentColor));
    });
  }

  void _endStroke() {
    setState(() {
      _points.add(_ColoredPoint(null, _currentColor)); // séparateur de trait
    });
  }

  void _clear() {
    setState(() {
      _points.clear(); // ⚠️ on efface SEULEMENT la couleur, pas l'image
    });
  }

  void _changeColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Colorie ta Miss France"),
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
                "Colorie le dessin sans modifier les traits.\n"
                    "Choisis une couleur, puis passe ton doigt sur l'image.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),

            // Zone de coloriage
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.rougeFonce, width: 2),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onPanStart: (details) => _addPoint(details.localPosition),
                      onPanUpdate: (details) => _addPoint(details.localPosition),
                      onPanEnd: (_) => _endStroke(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // 🖼️ Image de base non modifiable
                            Image.asset(
                              _baseImagePath,
                              fit: BoxFit.contain,
                            ),
                            // 🎨 Couleur par-dessus
                            CustomPaint(
                              painter: _DessinPainter(_points),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Palette de couleurs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text("Couleur : "),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _palette.map((color) {
                          final bool selected = color == _currentColor;
                          return GestureDetector(
                            onTap: () => _changeColor(color),
                            child: Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 4),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                                border: Border.all(
                                  color: selected
                                      ? Colors.white
                                      : Colors.black26,
                                  width: selected ? 3 : 1,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Bouton effacer
            SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _clear,
                        icon: const Icon(Icons.delete),
                        label: const Text("Effacer les couleurs"),
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

class _DessinPainter extends CustomPainter {
  final List<_ColoredPoint> points;

  _DessinPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 6.0   // un peu plus large pour bien colorier
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      if (p1.offset != null && p2.offset != null) {
        paint.color = p2.color;
        canvas.drawLine(p1.offset!, p2.offset!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DessinPainter oldDelegate) => true;
}
