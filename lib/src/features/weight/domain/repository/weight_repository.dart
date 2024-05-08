import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/core/error/failure.dart';

import '../../data/model/weight_model.dart';

abstract interface class WeightRepository {
  Future<Either<Failure, void>> saveWeightInKg(double weight);
  Future<Either<Failure, List<WeightModel>>> getAllWeightEntries();
  Future<Either<Failure, List<WeightModel>>> getSortedWeightEntriesWithTime();
  Future<Either<Failure, List<WeightModel>>> editWeightEntry(
      WeightModel weightModel);
  Future<Either<Failure, List<double>>> getWeightChangesInMonths(int months);
}
