part of 'weight_bloc.dart';

@immutable
abstract class WeightState extends Equatable {
  const WeightState();

  @override
  List<Object> get props => [];
}

class WeightInitial extends WeightState {}

class WeightLoaded extends WeightState {
  final List<WeightModel?> weightEntries;

  const WeightLoaded(this.weightEntries);

  @override
  List<Object> get props => [weightEntries];
}

class WeightError extends WeightState {
  final String message;

  const WeightError(this.message);

  @override
  List<Object> get props => [message];
}

class NoWeightFound extends WeightState {}
