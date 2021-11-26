part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}

class UpdateUserBalanceEvent extends UserEvent {
  final User user;
  int totalPurchased;
  UpdateUserBalanceEvent(this.user, this.totalPurchased);
}
