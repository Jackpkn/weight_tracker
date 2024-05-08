import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usercases.dart';
import '../repository/weight_repository.dart';

class AddWeightUseCase implements UseCase<void, double> {
  final WeightRepository repository;

  AddWeightUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(double weight) async {
    return repository.saveWeightInKg(weight);
  }
}
