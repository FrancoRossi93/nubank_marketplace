import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/core/network/network_info.dart';

import 'package:nubank_marketplace/features/user/data/datasources/user_local_data_source.dart';

import 'package:nubank_marketplace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:nubank_marketplace/features/user/data/models/user_model.dart';
import 'package:nubank_marketplace/features/user/data/repositories/user_repository_impl.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  UserRepositoryImpl repositoryImpl;
  MockRemoteDataSource remoteDataSource;
  MockLocalDataSource localDataSource;
  MockNetworkInfo networkInfo;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = UserRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
        networkInfo: networkInfo);
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

  group('getUser', () {
    final tUser = UserModel(id: "1", name: "test", balance: 100);
    test('should check if device is online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      //act
      repositoryImpl.getUser();
      //assert
      verify(networkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
          'should return a remote data when the call to remote data source is successfull',
          () async {
        //arrange
        when(remoteDataSource.getUser())
            .thenAnswer((realInvocation) async => tUser);
        //act
        final result = await repositoryImpl.getUser();
        //assert
        verify(remoteDataSource.getUser());
        expect(result, equals(Right(tUser)));
      });

      test(
          'should return server failure when the call to remote data source fails',
          () async {
        //arrange
        when(remoteDataSource.getUser())
            .thenThrow(ServerException(message: ""));
        //act
        final result = await repositoryImpl.getUser();
        //assert
        verify(remoteDataSource.getUser());
        expect(result, equals(Left(ServerFailure(message: ""))));
      });
    });

    runTestsOffline(() {
      test('should return ConnectionFailure if no connetion data is found',
          () async {
        //act
        final result = await repositoryImpl.getUser();
        //assert
        expect(result, equals(Left(ConnectionFailure(message: ""))));
      });
    });
  });
}
