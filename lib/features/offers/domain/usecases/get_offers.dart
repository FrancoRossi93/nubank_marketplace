import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/core/usecases/usecase.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';
import 'package:nubank_marketplace/features/offers/domain/repository/offers_repository.dart';

class GetOffers implements UseCase<List<ProductOffer>, NoParams> {
  final OffersRepository repository;
  GetOffers(this.repository);
  @override
  Future<Either<Failure, List<ProductOffer>>> call(NoParams) async {
    return await repository.getOffers();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
