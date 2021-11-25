import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';
import 'package:nubank_marketplace/features/offers/domain/usecases/get_offers.dart'
    as getOffersUseCase;

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final getOffersUseCase.GetOffers getOffers;
  OffersBloc(this.getOffers) : super(OffersEmpty());
  @override
  Stream<OffersState> mapEventToState(OffersEvent event) async* {
    if (event is GetOffersEvent) {
      yield OffersLoading();
      final failureOrUser = await getOffers(getOffersUseCase.NoParams());
      yield failureOrUser.fold(
          (l) => OffersError(l?.message), (r) => OffersLoaded(r));
    }
  }
}
