part of 'weight_bloc.dart';

@immutable
abstract class WeightEvent extends Equatable {
  const WeightEvent();

  @override
  List<Object> get props => [];
}

class AddWeight extends WeightEvent {
  final WeightModel weight;

  const AddWeight(this.weight);

  @override
  List<Object> get props => [weight];
}

class GetAllWeightEntries extends WeightEvent {
  final String username;

  const GetAllWeightEntries(this.username);

  @override
  List<Object> get props => [username];
}

class EditWeightEntry extends WeightEvent {
  final WeightModel weightModel;
  final String username;
  final int id;
  const EditWeightEntry(this.weightModel, this.username, this.id);

  @override
  List<Object> get props => [weightModel, username, id];
}

class GetWeightChangesInMonths extends WeightEvent {
  final int months;
  final String username;
  const GetWeightChangesInMonths(this.months, this.username);

  @override
  List<Object> get props => [months, username];
}

class GetSortedWeightEntriesWithTime extends WeightEvent {
  final String username;
  const GetSortedWeightEntriesWithTime(this.username);

  @override
  List<Object> get props => [username];
}

@immutable
class DeleteWeightEntry extends WeightEvent {
  final int id;

  const DeleteWeightEntry(this.id);
}
