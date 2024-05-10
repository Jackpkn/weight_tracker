import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

class GetAllWeightUseCase implements UseCase<List<WeightModel>, UserParams> {
  final WeightRepository repository;

  GetAllWeightUseCase(this.repository);

  @override
  Future<Either<Failure, List<WeightModel>>> call(UserParams username) {
    return repository.getAllWeightEntries(username: username.username);
  }
}

class UserParams {
  final String username;

  UserParams({required this.username});
}
