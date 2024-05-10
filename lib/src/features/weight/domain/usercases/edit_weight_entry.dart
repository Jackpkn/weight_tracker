import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

class EditWeightEntryUse implements UseCase<List<WeightModel?>, EditParams> {
  final WeightRepository repository;

  EditWeightEntryUse(this.repository);
  @override
  Future<Either<Failure, List<WeightModel?>>> call(
      EditParams editParams) async {
    return repository.editWeightEntry(
        editParams.weightModel, editParams.username, editParams.id);
  }
}

class EditParams {
  final WeightModel weightModel;
  final String username;
  final int id;

  EditParams(this.weightModel, this.username, this.id);
}
