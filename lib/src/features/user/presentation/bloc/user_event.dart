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
