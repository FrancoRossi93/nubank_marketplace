import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/utils/constants.dart';
import 'package:nubank_marketplace/core/utils/token.dart';

import 'package:nubank_marketplace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:nubank_marketplace/features/user/data/models/user_model.dart';

import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockTokenHelper extends Mock implements TokenHelper {}

void main() {
  UserRemoteDataSourceImpl remoteDataSourceImpl;
  MockHttpClient mockHttpClient;
  MockTokenHelper mockTokenHelper;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockTokenHelper = MockTokenHelper();
    remoteDataSourceImpl =
        UserRemoteDataSourceImpl(mockHttpClient, mockTokenHelper);
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

  group('getUser', () {
    final tUser = UserModel(id: "1", name: "test", balance: 100);
    final tQuery = json.encode({
      "query": "{viewer{id name balance}}",
      "operationName": null,
      "variables": null
    });
    final expectedResponse = {
      "data": {
        "viewer": {"id": "1", "name": "test", "balance": 100}
      }
    };
    test('should perform a POST request to url', () async {
      //arrange
      mockHttpClientPOST200Response(expectedResponse);
      //act
      await remoteDataSourceImpl.getUser();
      //assert
      verify(mockHttpClient.post(Uri.parse(API_URL),
          body: tQuery, headers: anyNamed('headers')));
      verify(mockTokenHelper.getCachedToken());
    });

    test('should return a UserModel when status code 200', () async {
      //arrange
      mockHttpClientPOST200Response(expectedResponse);
      //act
      final result = await remoteDataSourceImpl.getUser();
      //assert
      expect(result, equals(tUser));
    });
    test('should throw a ServerException when status code different from 200',
        () {
      //arrange
      mockHttpClientPOST404Response(expectedResponse);
      //act
      final call = remoteDataSourceImpl.getUser;
      //assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
