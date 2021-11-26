import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';
import 'package:nubank_marketplace/features/user/domain/usecases/get_user.dart'
    as getUserUseCase;
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final getUserUseCase.GetUser getUser;
  UserBloc(this.getUser) : super(UserEmpty());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserEvent) {
      yield UserLoading();
      final failureOrUser = await getUser(getUserUseCase.NoParams());
      yield failureOrUser.fold(
          (l) => UserError(l?.message), (r) => UserLoaded(r));
    } else if (event is UpdateUserBalanceEvent) {
      yield UserLoading();
      event.user.balance -= event.totalPurchased;
      yield UserLoaded(event.user);
    }
  }
}
