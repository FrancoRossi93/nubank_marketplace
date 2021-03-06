part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserEmpty extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String errorMessage;
  UserError(this.errorMessage);
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}
