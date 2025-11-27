import 'package:flutter/material.dart';
import '../models/miss.dart';

class MissCard extends StatefulWidget {
  final Miss miss;
  final Function() onChanged;
  final int currentIndex;
  final int totalMisses;
  final Function(int) onSelectMiss;

  const MissCard({
    super.key,
    required this.miss,
    required this.onChanged,
    required this.currentIndex,
    required this.totalMisses,
    required this.onSelectMiss,
  });

  @override
  State<MissCard> createState() => _MissCardState();
}

class _MissCardState extends State<MissCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Photo
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            widget.miss.photoUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),

        // Nom de la Miss
        Text(
          widget.miss.region,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // Sliders de notation
        _buildSlider("Élégance", (val) {
          setState(() => widget.miss.noteElegance = val.toInt());
          widget.onChanged();
        }, widget.miss.noteElegance),

        _buildSlider("Prestance", (val) {
          setState(() => widget.miss.notePrestance = val.toInt());
          widget.onChanged();
        }, widget.miss.notePrestance),

        _buildSlider("Originalité", (val) {
          setState(() => widget.miss.noteOriginalite = val.toInt());
          widget.onChanged();
        }, widget.miss.noteOriginalite),

        const SizedBox(height: 10),

        // Total
        Text(
          "Total : ${widget.miss.totalScore}/30",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Barre de progression
        LinearProgressIndicator(
          value: (widget.currentIndex + 1) / widget.totalMisses,
          //color: Colors.pinkAccent,
          //backgroundColor: Colors.pink[50],
        ),
        const SizedBox(height: 10),

        // Barre de navigation rapide
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(widget.totalMisses, (index) {
              final isSelected = index == widget.currentIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isSelected ?  const Color(0xFF8B0000) : Colors.grey[300],
                    foregroundColor: isSelected ? const Color(0xFFFFD700) : Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: () => widget.onSelectMiss(index),
                  child: Text("${index + 1}"),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(String label, Function(double) onChanged, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label : $value/10"),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 10,
          divisions: 10,
          label: "$value",
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Carte spécifique : Tenues traditionnelles (30 Miss)
// Utilise uniquement noteElegance comme note de tenue
// -----------------------------------------------------------------------------
class MissCardTenue extends StatefulWidget {
  final Miss miss;
  final Function() onChanged;
  final int currentIndex;
  final int totalMisses;
  final Function(int) onSelectMiss;

  const MissCardTenue({
    super.key,
    required this.miss,
    required this.onChanged,
    required this.currentIndex,
    required this.totalMisses,
    required this.onSelectMiss,
  });

  @override
  State<MissCardTenue> createState() => _MissCardTenueState();
}

class _MissCardTenueState extends State<MissCardTenue> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Photo
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            widget.miss.photoUrl,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 200,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text("📸 Photo manquante"),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Nom de la Miss
        Text(
          widget.miss.region,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // Slider de tenue
        _buildSlider(
          "Tenue traditionnelle",
              (val) {
            setState(() => widget.miss.noteElegance = val.toInt());
            widget.onChanged();
          },
          widget.miss.noteElegance,
        ),

        const SizedBox(height: 10),

        // Barre de progression
        LinearProgressIndicator(
          value: (widget.currentIndex + 1) / widget.totalMisses,
        ),
        const SizedBox(height: 10),

        // Barre de navigation rapide
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(widget.totalMisses, (index) {
              final isSelected = index == widget.currentIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isSelected ? const Color(0xFF8B0000) : Colors.grey[300],
                    foregroundColor:
                    isSelected ? const Color(0xFFFFD700) : Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: () => widget.onSelectMiss(index),
                  child: Text("${index + 1}"),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(
      String label, Function(double) onChanged, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label : $value/10"),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 10,
          divisions: 10,
          label: "$value",
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Carte spécifique : Questions des 5 finalistes
// Clarté -> noteElegance
// Aisance -> notePrestance
// Pertinence -> noteOriginalite
// -----------------------------------------------------------------------------
class MissCardQuestions extends StatefulWidget {
  final Miss miss;
  final Function() onChanged;
  final int currentIndex;
  final int totalMisses;
  final Function(int) onSelectMiss;

  const MissCardQuestions({
    super.key,
    required this.miss,
    required this.onChanged,
    required this.currentIndex,
    required this.totalMisses,
    required this.onSelectMiss,
  });

  @override
  State<MissCardQuestions> createState() => _MissCardQuestionsState();
}

class _MissCardQuestionsState extends State<MissCardQuestions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Photo
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            widget.miss.photoUrl,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 200,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text("📸 Photo manquante"),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Nom de la Miss
        Text(
          widget.miss.region,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // Sliders clarté / aisance / pertinence
        _buildSlider("Clarté", (val) {
          setState(() => widget.miss.noteElegance = val.toInt());
          widget.onChanged();
        }, widget.miss.noteElegance),

        _buildSlider("Aisance", (val) {
          setState(() => widget.miss.notePrestance = val.toInt());
          widget.onChanged();
        }, widget.miss.notePrestance),

        _buildSlider("Pertinence", (val) {
          setState(() => widget.miss.noteOriginalite = val.toInt());
          widget.onChanged();
        }, widget.miss.noteOriginalite),

        const SizedBox(height: 10),

        // Barre de progression
        LinearProgressIndicator(
          value: (widget.currentIndex + 1) / widget.totalMisses,
        ),
        const SizedBox(height: 10),

        // Barre de navigation rapide
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(widget.totalMisses, (index) {
              final isSelected = index == widget.currentIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isSelected ? const Color(0xFF8B0000) : Colors.grey[300],
                    foregroundColor:
                    isSelected ? const Color(0xFFFFD700) : Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: () => widget.onSelectMiss(index),
                  child: Text("${index + 1}"),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(
      String label, Function(double) onChanged, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label : $value/10"),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 10,
          divisions: 10,
          label: "$value",
          onChanged: onChanged,
        ),
      ],
    );
  }
}

