import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

class GetUserUseCase implements UseCase<List<UserModel>, NoParams> {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams noParams) async {
    return repository.getUserData();
  }
}
