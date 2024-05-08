import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/features/user/data/model/user_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usercases.dart';
import '../repository/user_repository.dart';

class GetUserUseCase implements UseCase<UserModel, NoParams> {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserModel?>> call(NoParams noParams) async {
    return repository.getUserData();
  }
}
