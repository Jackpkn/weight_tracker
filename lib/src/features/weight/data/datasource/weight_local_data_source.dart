import 'package:isar/isar.dart';

import '../../../../core/error/exception.dart';
import '../model/weight_model.dart';

abstract interface class WeightLocalDataSource {
  Future<void> saveWeightInKg(double weight);
  Future<List<WeightModel>> getAllWeightEntries();
  Future<List<WeightModel>> getSortedWeightEntriesWithTime();
  Future<List<WeightModel>> editWeightEntry(WeightModel weightModel);
  Future<List<double>> getWeightChangesInMonths(int months);
}

class WeightLocalDataSourceImpl implements WeightLocalDataSource {
  final Isar database;

  WeightLocalDataSourceImpl(this.database);

  @override
  Future<void> saveWeightInKg(double weight) async {
    try {
      await database.writeTxn(() {
        return database.weightModels.put(WeightModel(
          weight: weight,
          date: DateTime.now(),
        ));
      });
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<WeightModel>> getAllWeightEntries() async {
    try {
      return database.weightModels.where().findAll();
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<WeightModel>> getSortedWeightEntriesWithTime() async {
    try {
      return database.weightModels.where().sortByDate().findAll();
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<double>> getWeightChangesInMonths(int months) async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month - months, now.day);
      final end = DateTime(now.year, now.month, now.day);
      final entries = await database.weightModels
          .where()
          .filter()
          .dateBetween(start, end)
          .sortByDate()
          .findAll();
      return entries.map((e) => e.weight).toList();
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<WeightModel>> editWeightEntry(WeightModel weightModel) async {
    try {
      await database.writeTxn(() {
        return database.weightModels.put(weightModel);
      });
      return database.weightModels.where().findAll();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
