import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:weight_tracker/src/app_exports.dart';

class DeleteWeightEntryUse implements UseCase<void, Params> {
  final WeightRepository repository;

  DeleteWeightEntryUse(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return repository.deleteWeightEntry(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
