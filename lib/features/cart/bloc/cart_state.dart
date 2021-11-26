part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartEmpty extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductOffer> cartOffers;
  final int totalPurchased;
  CartLoaded({@required this.cartOffers, this.totalPurchased});
}

class CartError extends CartState {}

class CartPurchase extends CartState {}
