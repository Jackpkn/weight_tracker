import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

import '../../../../core/error/exception.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource localDataSource;
  UserRepositoryImpl(this.localDataSource);
  @override
  Future<Either<Failure, void>> createUser({
    required UserModel userModel,
  }) {
    return _getUser(() => localDataSource.createUser(newUser: userModel));
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUserData() async {
    return _getUser(() => localDataSource.getUserData());
  }

  Future<Either<Failure, T>> _getUser<T>(Future<T> Function() fn) async {
    try {
      final result = await fn();
      return Right(result);
    } on IsarException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String username) async {
    try {
      await localDataSource.deleteUser(username);
      return Right(());
    } on IsarException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
