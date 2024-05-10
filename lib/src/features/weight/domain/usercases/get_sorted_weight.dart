import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

class GetSortedWeight implements UseCase<List<WeightModel>, String> {
  final WeightRepository repository;

  GetSortedWeight(this.repository);

  @override
  Future<Either<Failure, List<WeightModel>>> call(String username) async {
    return await repository.getSortedWeightEntriesWithTime(username);
  }
}
