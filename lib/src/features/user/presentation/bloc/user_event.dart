part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {}

class CreateUserEvent extends UserEvent {
  final String username;

  CreateUserEvent({required this.username});

  @override
  List<Object?> get props => [username];
}

class GetUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class DeleteUser extends UserEvent {
  final String username;

  DeleteUser(
    this.username,
  );
  @override
  // TODO: implement props
  List<Object?> get props => [username];
}
