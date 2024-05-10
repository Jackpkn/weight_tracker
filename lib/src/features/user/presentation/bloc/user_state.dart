part of 'user_bloc.dart';

@immutable
sealed class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserAdding extends UserState {
  @override
  List<Object> get props => [];
}

final class UserAdded extends UserState {
  @override
  List<Object> get props => [];
}

class UserData extends UserState {
  final List<UserModel> users;

  UserData(this.users);

  @override
  List<Object> get props => [users];
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
  @override
  List<Object> get props => [message];
}
