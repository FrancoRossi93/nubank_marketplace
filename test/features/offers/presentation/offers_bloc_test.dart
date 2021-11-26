import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_model.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_offer_model.dart';

import 'package:nubank_marketplace/features/offers/domain/usecases/get_offers.dart'
    as getOffersUseCase;
import 'package:nubank_marketplace/features/offers/presentation/bloc/offers_bloc.dart';

class MockGetOffers extends Mock implements getOffersUseCase.GetOffers {}

void main() {
  OffersBloc bloc;
  MockGetOffers mockGetOffers;

  setUp(() {
    mockGetOffers = MockGetOffers();
    bloc = OffersBloc(mockGetOffers);
  });

  test('initial state should be empty', () {
    //assert
    expect(bloc.state, equals(OffersEmpty()));
  });

  group('getOffers', () {
    final List<ProductOfferModel> tProductOffer = [
      ProductOfferModel(
          id: "1",
          price: 100,
          product: ProductModel(
              id: "1", name: "test", description: "test", imageUrl: "test"))
    ];
    test('should get data from the usecase', () async {
      //arrange
      when(mockGetOffers(getOffersUseCase.NoParams()))
          .thenAnswer((realInvocation) async => Right(tProductOffer));
      //act
      bloc.add(GetOffersEvent());
      await untilCalled(mockGetOffers(getOffersUseCase.NoParams()));
      //assert
      verify(mockGetOffers(getOffersUseCase.NoParams()));
    });
    test('should emit [OffersLoading, OffersLoaded] when data is gotten', () {
      //arrange
      when(mockGetOffers(getOffersUseCase.NoParams()))
          .thenAnswer((realInvocation) async => Right(tProductOffer));
      //assert
      final expected = [OffersLoading(), OffersLoaded(tProductOffer)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetOffersEvent());
    });
    test('should emit [OffersLoading, OffersError] when getting data fails',
        () {
      //arrange
      when(mockGetOffers(getOffersUseCase.NoParams()))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));
      //assert
      final expected = [OffersLoading(), OffersError("")];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetOffersEvent());
    });
  });
}
