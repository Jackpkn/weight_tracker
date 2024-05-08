import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/core/error/exception.dart';
import 'package:weight_tracker/src/core/error/failure.dart';
import 'package:weight_tracker/src/features/user/data/model/user_model.dart';
import 'package:weight_tracker/src/features/user/domain/repository/user_repository.dart';

import '../datasource/local_data_source.dart';

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
  Future<Either<Failure, UserModel?>> getUserData() async {
    return _getUser(() => localDataSource.getUserData());
  }

  Future<Either<Failure, T?>> _getUser<T>(Future<T?> Function() fn) async {
    try {
      final result = await fn();
      return Right(result);
    } on IsarException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
