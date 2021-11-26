import 'package:dartz/dartz.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';

abstract class OffersRepository {
  Future<Either<Failure, List<ProductOffer>>> getOffers();
}
