import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/src/app_exports.dart';

import '../../domain/usercases/delete_weight_entry.dart';

part 'weight_event.dart';
part 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  final AddWeightUseCase _addWeightUseCase;
  final GetAllWeightUseCase _getAllWeightEntries;
  final EditWeightEntryUse _editWeightEntry;
  final GetSortedWeight _entriesWithTime;

  final DeleteWeightEntryUse _deleteWeightEntryUse;
  WeightBloc({
    required AddWeightUseCase addWeightUseCase,
    required GetAllWeightUseCase getWeightEntries,
    required EditWeightEntryUse editWeightEntry,
    required GetSortedWeight entriesWithTime,
    required DeleteWeightEntryUse deleteWeightEntryUse,
  })  : _addWeightUseCase = addWeightUseCase,
        _getAllWeightEntries = getWeightEntries,
        _editWeightEntry = editWeightEntry,
        _entriesWithTime = entriesWithTime,
        _deleteWeightEntryUse = deleteWeightEntryUse,
        super(WeightInitial()) {
    on<AddWeight>((event, emit) async => _addWeight(event, emit));
    on<GetAllWeightEntries>(
        (event, emit) async => await _getAllWeight(event, emit));
    on<EditWeightEntry>((event, emit) async => _editWeight(event, emit));
    on<GetSortedWeightEntriesWithTime>(
        (event, emit) async => _getSortedWeight(event, emit));
    on<DeleteWeightEntry>((event, emit) async => _deleteWeight(event, emit));
  }

  void _addWeight(AddWeight event, Emitter<WeightState> emit) async {
    final result = await _addWeightUseCase(event.weight);
    result.fold(
      (failure) => emit(WeightError(failure.message)),
      (weight) async {
        final currentState = state;
        if (currentState is WeightLoaded) {
          final updatedWeightEntries = [...currentState.weightEntries, weight];
          emit(WeightLoaded(updatedWeightEntries));
        } else {
          emit(WeightLoaded([weight]));
        }
      },
    );
  }

  Future<void> _getAllWeight(
      GetAllWeightEntries event, Emitter<WeightState> emit) async {
    final result =
        await _getAllWeightEntries(UserParams(username: event.username));
    result.fold(
      (failure) => emit(WeightError(failure.message)),
      (weight) async {
        if (weight.isEmpty) {
          emit(NoWeightFound());
        } else {
          emit(WeightLoaded(weight));
        }
      },
    );
  }

  void _getSortedWeight(
      GetSortedWeightEntriesWithTime event, Emitter<WeightState> emit) async {
    final result = await _entriesWithTime(event.username);
    result.fold(
      (failure) => emit(WeightError(failure.message)),
      (weight) async {
        emit(WeightLoaded(weight));
      },
    );
  }

  void _editWeight(EditWeightEntry event, Emitter<WeightState> emit) async {
    final result = await _editWeightEntry(
        EditParams(event.weightModel, event.username, event.id));

    await result.fold(
      (failure) async {
        emit(WeightError(failure.message));
      },
      (weightEntry) async {
        emit(WeightLoaded(weightEntry));
      },
    );
  }

  void _deleteWeight(DeleteWeightEntry event, Emitter<WeightState> emit) async {
    final result = await _deleteWeightEntryUse(Params(id: event.id));

    result.fold(
      (failure) => emit(WeightError(failure.message)),
      (_) async {
        final currentState = state;
        if (currentState is WeightLoaded) {
          final updatedWeightEntries = currentState.weightEntries
              .where((entry) => entry?.id != event.id)
              .toList();
          emit(WeightLoaded(updatedWeightEntries));
        }
      },
    );
  }
}
