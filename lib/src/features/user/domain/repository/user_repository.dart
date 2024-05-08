import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/core/error/failure.dart';
import 'package:weight_tracker/src/features/user/data/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<Failure, void>> createUser({
    required UserModel userModel,
  });
  Future<Either<Failure, UserModel?>> getUserData();
}
