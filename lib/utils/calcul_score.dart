import '../models/miss.dart';
import '../models/joueur_data.dart';

class CalculScore {
  int total(JoueurData data) {
    int score = 0;

    // --- 1. Pari Miss favorite ---
    if (data.classementOfficiel.isNotEmpty &&
        data.classementOfficiel.last.region.toLowerCase() ==
            data.missPariee.toLowerCase()) {
      score += 50;
    }

    // --- 2. Points Top 15 ---
    final top15 = data.classement15.map((m) => m.region).toSet();
    final officiel15 = data.classementOfficiel.take(15).map((m) => m.region).toSet();
    final commun15 = top15.intersection(officiel15);
    score += commun15.length * 2;

    // --- 3. Points Top 5 ---
    final top5 = data.classement5.map((m) => m.region).toSet();
    final officiel5 = data.classementOfficiel.take(5).map((m) => m.region).toSet();
    final commun5 = top5.intersection(officiel5);
    score += commun5.length * 4;

    // --- 4. Classement final ---
    final missFrance = data.classementOfficiel.last.region.toLowerCase();
    if (top5.contains(missFrance)) {
      final indexJoueur =
      data.classement5.indexWhere((m) => m.region.toLowerCase() == missFrance);
      if (indexJoueur == 4) {
        score += 10; // Miss France trouvée
      } else if (indexJoueur >= 0) {
        score += 5; // dans le top 5
      }
    }

    // --- 5. Bonus cohérence des notes ---
    // (optionnel : ici simple bonus de 0 à 10 en fonction de la dispersion)
    score += 5; // à ajuster plus tard

    return score;
  }

  Map<String, int> detail(JoueurData data) {
    int pari = 0, top15 = 0, top5 = 0, finale = 0, coherence = 5;

    if (data.classementOfficiel.isNotEmpty &&
        data.classementOfficiel.last.region.toLowerCase() ==
            data.missPariee.toLowerCase()) {
      pari = 50;
    }

    final top15set = data.classement15.map((m) => m.region).toSet();
    final officiel15set = data.classementOfficiel.take(15).map((m) => m.region).toSet();
    top15 = top15set.intersection(officiel15set).length * 2;

    final top5set = data.classement5.map((m) => m.region).toSet();
    final officiel5set = data.classementOfficiel.take(5).map((m) => m.region).toSet();
    top5 = top5set.intersection(officiel5set).length * 4;

    final missFrance = data.classementOfficiel.last.region.toLowerCase();
    if (top5set.contains(missFrance)) {
      final indexJoueur =
      data.classement5.indexWhere((m) => m.region.toLowerCase() == missFrance);
      if (indexJoueur == 4) {
        finale = 10;
      } else if (indexJoueur >= 0) {
        finale = 5;
      }
    }

    return {
      'pari': pari,
      'top15': top15,
      'top5': top5,
      'finale': finale,
      'coherence': coherence,
      'total': pari + top15 + top5 + finale + coherence
    };
  }
}
