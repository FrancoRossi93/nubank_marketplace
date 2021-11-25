part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddOfferToCartEvent extends CartEvent {
  final List<ProductOffer> initialCart;
  final ProductOffer offer;
  AddOfferToCartEvent({this.initialCart, this.offer});
}

class RemoveOfferFromCartEvent extends CartEvent {
  final List<ProductOffer> initialCart;
  final ProductOffer offer;
  RemoveOfferFromCartEvent({this.initialCart, this.offer});
}
