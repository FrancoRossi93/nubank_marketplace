import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/core/network/network_info.dart';

import 'package:nubank_marketplace/features/offers/data/datasources/offers_remote_data_source.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_model.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_offer_model.dart';

import 'package:nubank_marketplace/features/offers/data/repositories/offers_repository_impl.dart';

class MockRemoteDataSource extends Mock implements OffersRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  OffersRepositoryImpl repositoryImpl;
  MockRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;
  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = OffersRepositoryImpl(
        remoteDataSource: remoteDataSource, networkInfo: networkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
      });
      body();
    });
  }

  group('getOffers', () {
    final List<ProductOfferModel> tProductOffer = [
      ProductOfferModel(
          id: "1",
          price: 100,
          product: ProductModel(
              id: "1", name: "test", description: "test", imageUrl: "test"))
    ];
    test('should check if device is online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      //act
      repositoryImpl.getOffers();
      //assert
      verify(networkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
          'should return a remote data when the call to remote data source is successfull',
          () async {
        //arrange
        when(remoteDataSource.getOffers())
            .thenAnswer((realInvocation) async => tProductOffer);
        //act
        final result = await repositoryImpl.getOffers();
        //assert
        verify(remoteDataSource.getOffers());
        expect(result, equals(Right(tProductOffer)));
      });

      test(
          'should return a server failure when the call to remote data source fails',
          () async {
        //arrange
        when(remoteDataSource.getOffers())
            .thenThrow(ServerException(message: ""));
        //act
        final result = await repositoryImpl.getOffers();
        //assert
        verify(remoteDataSource.getOffers());
        expect(result, equals(Left(ServerFailure(message: ""))));
      });
    });
    runTestsOffline(() {
      test('should return ConnectionFailure if no connetion data is found',
          () async {
        //act
        final result = await repositoryImpl.getOffers();
        //assert
        expect(result, equals(Left(ConnectionFailure(message: ""))));
      });
    });
  });
}
