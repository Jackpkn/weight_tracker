import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/src/features/user/data/model/user_model.dart';

import '../../../../core/usecases/usercases.dart';
import '../../../weight/domain/usercases/delete_weight_entry.dart';
import '../../domain/usecases/create_user_use_case.dart';
import '../../domain/usecases/delete_user_use_cases.dart';
import '../../domain/usecases/get_user_use_cases.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUserUseCase _createUserUseCase;
  final GetUserUseCase _getUserUseCase;
  final DeleteUserUseCase _deleteUserUseCase;

  UserBloc({
    required CreateUserUseCase createUserUseCase,
    required GetUserUseCase getUserUseCase,
    required DeleteUserUseCase deleteUserUseCase,
    required DeleteWeightEntryUse deleteWeightEntryUse,
  })  : _createUserUseCase = createUserUseCase,
        _getUserUseCase = getUserUseCase,
        _deleteUserUseCase = deleteUserUseCase,
        super(UserInitial()) {
    on<CreateUserEvent>(_addUser);
    on<GetUserEvent>(_getUserData);
    on<DeleteUser>(_deleteUser);
  }

  void _addUser(CreateUserEvent event, Emitter<UserState> emit) async {
    emit(UserAdding());
    // final userModel = UserModel(name: event.username);
    try {
      final userModel = UserModel(name: event.username);
      final result = await _createUserUseCase(userModel);
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (_) {
          emit(UserAdded());
          add(GetUserEvent()); // Fetch the updated list of users
        },
      );
      // emit(UserAdded());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _getUserData(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await _getUserUseCase(NoParams());
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserData(user)),
    );
  }

  void _deleteUser(DeleteUser event, Emitter<UserState> emit) async {
    final userResult = await _deleteUserUseCase(event.username);

    userResult.fold(
      (failure) {
        emit(UserError(failure.message));
      },
      (u) {
        add(GetUserEvent());
      },
    );
  }
}
