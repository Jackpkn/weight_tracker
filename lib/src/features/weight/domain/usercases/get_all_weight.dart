import 'package:fpdart/src/either.dart';
import 'package:weight_tracker/src/core/error/failure.dart';

import '../../../../core/usecases/usercases.dart';
import '../../data/model/weight_model.dart';
import '../repository/weight_repository.dart';

class GetAllWeightUseCase implements UseCase<List<WeightModel>, NoParams> {
  final WeightRepository repository;

  GetAllWeightUseCase(this.repository);

  @override
  Future<Either<Failure, List<WeightModel>>> call(NoParams params) {
    return repository.getAllWeightEntries();
  }
}
