import 'package:isar/isar.dart';

part 'weight_model.g.dart';

@Collection()
class WeightModel {
  Id? id;

  double? weight;
  DateTime? date;
  String? username;

  WeightModel({
    required this.weight,
    required this.date,
    required this.username,
  });
}
