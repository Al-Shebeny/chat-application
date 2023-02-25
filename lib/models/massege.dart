import '../constants.dart';

class Massege {
  final String massege;
  final String id;

  Massege(
    this.massege,
    this.id,
  );

  factory Massege.fromJson(jsonData) {
    return Massege(jsonData[kMassege], jsonData['id']);
  }
}
