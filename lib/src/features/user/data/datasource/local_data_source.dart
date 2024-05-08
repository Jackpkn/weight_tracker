import 'package:isar/isar.dart';
import 'package:weight_tracker/src/core/error/exception.dart';
import 'package:weight_tracker/src/core/error/failure.dart';

import '../model/user_model.dart';

abstract interface class LocalDataSource {
  Future<void> createUser({required UserModel newUser});
  Future<UserModel?> getUserData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final Isar database;

  LocalDataSourceImpl(this.database);

  @override
  Future<void> createUser({
    required UserModel newUser,
  }) async {
    try {
      await database.writeTxn(() {
        return database.userModels.put(newUser);
      });
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel?> getUserData() async {
    try {
      return database.userModels.where().findFirst();
    } on IsarException catch (e) {
      throw Failure(e.toString());
    }
  }
}
