import 'package:flutter/material.dart';
import '../utils/theme.dart';

class MiniJeuDessinerMissFrance extends StatefulWidget {
  const MiniJeuDessinerMissFrance({super.key});

  @override
  State<MiniJeuDessinerMissFrance> createState() =>
      _MiniJeuDessinerMissFranceState();
}

// Petit modèle pour mémoriser un point + sa couleur
class _ColoredPoint {
  final Offset? offset;
  final Color color;
  _ColoredPoint(this.offset, this.color);
}

class _MiniJeuDessinerMissFranceState
    extends State<MiniJeuDessinerMissFrance> {
  final List<_ColoredPoint> _points = [];

  // Couleur actuelle utilisée pour dessiner
  Color _currentColor = AppTheme.rougeFonce;

  // Palette proposée
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
      _points.add(_ColoredPoint(null, _currentColor)); // Séparateur
    });
  }

  void _clear() {
    setState(() {
      _points.clear();
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
        title: const Text("Dessine ta Miss France"),
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
                "Utilise ton doigt pour dessiner la couronne ta Miss France idéale.\n"
                    "Astuce : tourne ton téléphone en paysage pour plus de place 😉",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),

            // Zone de dessin
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.rougeFonce, width: 2),
                ),
                child: GestureDetector(
                  onPanStart: (details) => _addPoint(details.localPosition),
                  onPanUpdate: (details) => _addPoint(details.localPosition),
                  onPanEnd: (_) => _endStroke(),
                  child: CustomPaint(
                    painter: _DessinPainter(_points),
                    child: Container(),
                  ),
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
                        label: const Text("Effacer tout"),
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
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      if (p1.offset != null && p2.offset != null) {
        paint.color = p2.color; // couleur du trait
        canvas.drawLine(p1.offset!, p2.offset!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DessinPainter oldDelegate) {
    // On redessine dès que la liste change
    return true;
  }
}
