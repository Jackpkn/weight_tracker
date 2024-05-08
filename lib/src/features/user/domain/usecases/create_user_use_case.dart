import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/features/user/data/model/user_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usercases.dart';
import '../repository/user_repository.dart';

class CreateUserUseCase implements UseCase<void, UserModel> {
  final UserRepository _userRepository;

  CreateUserUseCase(this._userRepository);

  @override
  Future<Either<Failure, void>> call(UserModel user) async {
    return _userRepository.createUser(userModel: user);
  }
}
