import 'package:isar/isar.dart';
import 'package:weight_tracker/src/core/error/exception.dart';
import 'package:weight_tracker/src/core/error/failure.dart';
import 'package:weight_tracker/src/features/weight/data/model/weight_model.dart';

import '../model/user_model.dart';

abstract interface class LocalDataSource {
  Future<void> createUser({required UserModel newUser});
  Future<List<UserModel>> getUserData();
  Future<void> deleteUser(String username);
}

class LocalDataSourceImpl implements LocalDataSource {
  final Isar database;

  LocalDataSourceImpl(this.database);

  @override
  Future<void> createUser({
    required UserModel newUser,
  }) async {
    try {
      final existingUser = await getUserByUsername(newUser.name.toString());
      if (existingUser != null) {
        throw Exception('User already exists');
      }
      await database.writeTxn(() {
        return database.userModels.put(newUser);
      });
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<UserModel>> getUserData() async {
    try {
      return database.userModels.where().findAll();
    } on IsarException catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      return database.userModels
          .where()
          .filter()
          .nameEqualTo(username)
          .findFirst();
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteUser(String username) async {
    try {
      // print(username);
      await database.writeTxn(() async {
        await database.userModels
            .where()
            .filter()
            .nameEqualTo(username)
            .deleteAll();
        await database.weightModels
            .where()
            .filter()
            .usernameEqualTo(username)
            .deleteAll();
      });
    } on IsarException catch (e) {
      throw Exception(e.toString());
    }
  }
}
