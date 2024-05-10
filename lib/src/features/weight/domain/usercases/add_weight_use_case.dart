import 'package:fpdart/fpdart.dart';

import '../../../../app_exports.dart';

class AddWeightUseCase implements UseCase<void, WeightModel> {
  final WeightRepository repository;

  AddWeightUseCase(this.repository);
  @override
  Future<Either<Failure, WeightModel>> call(WeightModel weight) async {
    return repository.saveWeight(weight);
  }
}
