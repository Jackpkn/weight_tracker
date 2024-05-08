import 'package:isar/isar.dart';

part 'weight_model.g.dart';

@collection
class WeightModel {
  final Id id = Isar.autoIncrement;
  final double weight;
  final DateTime date;
  WeightModel({
    required this.weight,
    required this.date,
  });
}
