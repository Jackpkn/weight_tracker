import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

abstract interface class WeightRepository {
  Future<Either<Failure, WeightModel>> saveWeight(WeightModel weight);
  Future<Either<Failure, List<WeightModel>>> getAllWeightEntries(
      {required String username});
  Future<Either<Failure, List<WeightModel>>> getSortedWeightEntriesWithTime(
      String username);
  Future<Either<Failure, List<WeightModel?>>> editWeightEntry(
      WeightModel weightModel, String username, int id);

  Future<Either<Failure, void>> deleteWeightEntry(int id);
}
