class ScoreManager {
  static int computeScore({
    required int matched20,
    required int matched5,
    required bool pariInitialOk,
    required bool finalOk,
  }) {
    int score = 0;
    score += matched20;
    score += matched5;
    if (finalOk) score += 5;
    if (pariInitialOk) score += 3;
    return score;
  }
}
