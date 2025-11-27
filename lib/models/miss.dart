class Miss {
  final int id;
  final String region; // Nom de la région
  final String photoUrl; // Image associée à la Miss
  int noteElegance;
  int notePrestance;
  int noteOriginalite;

  Miss({
    required this.id,
    required this.region,
    required this.photoUrl,
    this.noteElegance = 0,
    this.notePrestance = 0,
    this.noteOriginalite = 0,
  });

  int get totalScore => noteElegance + notePrestance + noteOriginalite;

  // getter qui retourne la moyenne par critère (0..10)
  double get moyenne => totalScore / 3.0;
}
