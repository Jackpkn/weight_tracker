import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

abstract interface class UserRepository {
  Future<Either<Failure, void>> createUser({
    required UserModel userModel,
  });
  Future<Either<Failure, List<UserModel>>> getUserData();
  Future<Either<Failure, void>> deleteUser(String username);
}
