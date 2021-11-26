import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/failures.dart';

import 'package:nubank_marketplace/core/network/network_info.dart';
import 'package:nubank_marketplace/features/offers/data/datasources/offers_remote_data_source.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';
import 'package:nubank_marketplace/features/offers/domain/repository/offers_repository.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OffersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OffersRepositoryImpl(
      {@required this.remoteDataSource, @required this.networkInfo});
  @override
  Future<Either<Failure, List<ProductOffer>>> getOffers() async {
    if (await networkInfo.isConnected) {
      try {
        List<ProductOffer> offers = await remoteDataSource.getOffers();
        if (offers is List) {
          return Right(offers);
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ConnectionFailure(
          message: "The device is offline. Check your internet connection."));
    }
  }
}
