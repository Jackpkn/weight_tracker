import 'package:isar/isar.dart';

import '../../../../core/error/exception.dart';
import '../model/weight_model.dart';

abstract interface class WeightLocalDataSource {
  Future<WeightModel> saveWeightInKg(WeightModel weight);
  Future<List<WeightModel>> getAllWeightEntries({required String username});
  Future<List<WeightModel>> getSortedWeightEntriesWithTime(
      {required String username});
  Future<List<WeightModel?>> editWeightEntry(
      WeightModel weightModel, String username, int id);

  Future<void> deleteWeightEntry(int id);
}

class WeightLocalDataSourceImpl implements WeightLocalDataSource {
  final Isar database;

  WeightLocalDataSourceImpl(this.database);

  @override
  Future<WeightModel> saveWeightInKg(WeightModel weight) async {
    try {
      int id = await database.writeTxn(() async {
        return await database.weightModels.put(WeightModel(
          weight: weight.weight,
          date: weight.date,
          username: weight.username,
        ));
      });

      weight.id = id; // Assign the id to your weight object
      return weight;
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<WeightModel>> getAllWeightEntries(
      {required String username}) async {
    try {
      return database.weightModels
          .where()
          .filter()
          .usernameEqualTo(username)
          .findAll();
      // return database.weightModels.where().findAll();
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<WeightModel>> getSortedWeightEntriesWithTime(
      {required String username}) async {
    try {
      return database.weightModels
          .where()
          .filter()
          .usernameEqualTo(username)
          .sortByDate()
          .findAll();
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<WeightModel?>> editWeightEntry(
      WeightModel weightModel, String username, int id) async {
    try {
      await database.writeTxn(() async {
        final existingWeightModel = await database.weightModels
            .where()
            .filter()
            .usernameEqualTo(username)
            .and()
            .idEqualTo(id)
            .findFirst();

        if (existingWeightModel != null) {
          // Update the existingWeightModel with the new weightModel's values
          existingWeightModel.weight = weightModel.weight;
          existingWeightModel.date = weightModel.date;

          // Put the updated existingWeightModel back into the database
          await database.weightModels.put(existingWeightModel);
        }
      });
      return database.weightModels
          .where()
          .filter()
          .usernameEqualTo(username)
          .findAll();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteWeightEntry(int id) async {
    try {
      await database.writeTxn(() async {
        await database.weightModels.delete(id);
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
