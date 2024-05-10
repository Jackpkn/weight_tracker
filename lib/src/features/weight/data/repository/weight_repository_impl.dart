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
  Future<Either<Failure, List<WeightModel>>> getAllWeightEntries(
      {required String username}) {
    return _weightFunction<List<WeightModel>>(
        () => weightLocalDataSource.getAllWeightEntries(username: username));
  }

  @override
  Future<Either<Failure, List<WeightModel>>> getSortedWeightEntriesWithTime(
      String username) {
    return _weightFunction<List<WeightModel>>(() => weightLocalDataSource
        .getSortedWeightEntriesWithTime(username: username));
  }

  @override
  Future<Either<Failure, WeightModel>> saveWeight(WeightModel weight) {
    return _weightFunction(() => weightLocalDataSource.saveWeightInKg(weight));
  }

  @override
  Future<Either<Failure, List<WeightModel?>>> editWeightEntry(
      WeightModel weightModel, String username, int id) {
    return _weightFunction<List<WeightModel?>>(
        () => weightLocalDataSource.editWeightEntry(weightModel, username, id));
  }

  Future<Either<Failure, T>> _weightFunction<T>(Future<T> Function() fn) async {
    try {
      final result = await fn();
      return Right(result);
    } on IsarException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWeightEntry(int id) async {
    try {
      await weightLocalDataSource.deleteWeightEntry(id);
      return const Right(());
    } on IsarException catch (e) {
      return Left((Failure(e.message)));
    }
  }
}
