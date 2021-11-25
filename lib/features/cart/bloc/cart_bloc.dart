import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty());
  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddOfferToCartEvent) {
      yield CartLoading();
      event.initialCart.add(event.offer);
      yield CartLoaded(cartOffers: event.initialCart);
    } else if (event is RemoveOfferFromCartEvent) {
      yield CartLoading();
      event.initialCart.remove(event.offer);
      yield CartLoaded(cartOffers: event.initialCart);
    }
  }
}
