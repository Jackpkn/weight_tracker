import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/core/error/failure.dart';
import 'package:weight_tracker/src/features/weight/data/model/weight_model.dart';
import 'package:weight_tracker/src/features/weight/domain/repository/weight_repository.dart';

import '../../../../core/error/exception.dart';
import '../datasource/weight_local_data_source.dart';

class WeightRepositoryImpl implements WeightRepository {
  final WeightLocalDataSource weightLocalDataSource;
  WeightRepositoryImpl(this.weightLocalDataSource);

  @override
  Future<Either<Failure, List<WeightModel>>> getAllWeightEntries() {
    return _weightFunction<List<WeightModel>>(
        () => weightLocalDataSource.getAllWeightEntries());
  }

  @override
  Future<Either<Failure, List<WeightModel>>> getSortedWeightEntriesWithTime() {
    return _weightFunction<List<WeightModel>>(
        () => weightLocalDataSource.getSortedWeightEntriesWithTime());
  }

  @override
  Future<Either<Failure, List<double>>> getWeightChangesInMonths(int months) {
    return _weightFunction<List<double>>(
        () => weightLocalDataSource.getWeightChangesInMonths(months));
  }

  @override
  Future<Either<Failure, void>> saveWeightInKg(double weight) {
    return _weightFunction(() => weightLocalDataSource.saveWeightInKg(weight));
  }

  @override
  Future<Either<Failure, List<WeightModel>>> editWeightEntry(
      WeightModel weightModel) {
    return _weightFunction<List<WeightModel>>(
        () => weightLocalDataSource.editWeightEntry(weightModel));
  }

  Future<Either<Failure, T>> _weightFunction<T>(Future<T> Function() fn) async {
    try {
      final result = await fn();
      return Right(result);
    } on IsarException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
