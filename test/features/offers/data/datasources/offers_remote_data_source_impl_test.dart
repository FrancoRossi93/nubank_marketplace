import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/utils/constants.dart';
import 'package:nubank_marketplace/core/utils/token.dart';
import 'package:nubank_marketplace/features/offers/data/datasources/offers_remote_data_source.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_model.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_offer_model.dart';

import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockTokenHelper extends Mock implements TokenHelper {}

void main() {
  OffersRemoteDataSourceImpl remoteDataSourceImpl;
  MockHttpClient mockHttpClient;
  MockTokenHelper mockTokenHelper;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockTokenHelper = MockTokenHelper();
    remoteDataSourceImpl =
        OffersRemoteDataSourceImpl(mockHttpClient, mockTokenHelper);
  });

  void mockHttpClientPOST200Response(expectedResponse) {
    when(mockHttpClient.post(any,
            body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((realInvocation) async =>
            http.Response(json.encode(expectedResponse), 200));
  }

  void mockHttpClientPOST404Response(expectedResponse) {
    when(mockHttpClient.post(any,
            body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((realInvocation) async =>
            http.Response("Something went wrong", 404));
  }

  group('getOffers', () {
    final List<ProductOfferModel> tProductOffer = [
      ProductOfferModel(
          id: "1",
          price: 100,
          product: ProductModel(
              id: "1", name: "test", description: "test", imageUrl: "test"))
    ];
    final tQuery = json.encode({
      "query":
          "{viewer{ offers {id,price,product {id name description image}}}}",
      "operationName": null,
      "variables": null
    });
    final expectedResponse = json.decode(fixture('offers_response.json'));

    test('should perform a POST request to url', () async {
      //arrange
      mockHttpClientPOST200Response(expectedResponse);
      //act
      await remoteDataSourceImpl.getOffers();
      //assert
      verify(mockHttpClient.post(Uri.parse(API_URL),
          body: tQuery, headers: anyNamed('headers')));
      verify(mockTokenHelper.getCachedToken());
    });

    test('should return a ProductOfferModel when status code is 200', () async {
      //arrange
      mockHttpClientPOST200Response(expectedResponse);
      //act
      final result = await remoteDataSourceImpl.getOffers();
      //assert
      expect(result, equals(tProductOffer));
    });

    test(
        'should thrwo a ServerException when status code is different from 200',
        () {
      //arrange
      mockHttpClientPOST404Response(expectedResponse);
      //act
      final call = remoteDataSourceImpl.getOffers;
      //assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
