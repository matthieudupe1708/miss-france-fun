import '../models/miss.dart';

class JoueurData {
  final String missPariee;
  List<Miss> classement40;
  List<Miss> classement15;
  List<Miss> classement5;
  List<Miss> classementOfficiel;

  JoueurData({
    required this.missPariee,
    required this.classement40,
    required this.classement15,
    required this.classement5,
    required this.classementOfficiel,
  });
}
