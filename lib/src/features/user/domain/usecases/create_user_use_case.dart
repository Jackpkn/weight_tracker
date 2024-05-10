import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

class CreateUserUseCase implements UseCase<void, UserModel> {
  final UserRepository _userRepository;

  CreateUserUseCase(this._userRepository);

  @override
  Future<Either<Failure, void>> call(UserModel user) async {
    return _userRepository.createUser(userModel: user);
  }
}
