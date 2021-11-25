part of 'offers_bloc.dart';

abstract class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object> get props => [];
}

class OffersInitial extends OffersState {}

class OffersEmpty extends OffersState {}

class OffersLoading extends OffersState {}

class OffersError extends OffersState {
  final String errorMessage;
  OffersError(this.errorMessage);
}

class OffersLoaded extends OffersState {
  final List<ProductOffer> offers;
  OffersLoaded(this.offers);
}
