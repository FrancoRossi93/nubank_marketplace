import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/features/user/data/models/user_model.dart';
import 'package:nubank_marketplace/features/user/domain/usecases/get_user.dart'
    as getUserUseCase;
import 'package:nubank_marketplace/features/user/presentation/bloc/user_bloc.dart';

import '../../../fixtures/fixture_reader.dart';

class MockGetUser extends Mock implements getUserUseCase.GetUser {}

void main() {
  UserBloc bloc;
  MockGetUser mockGetUser;

  setUp(() {
    mockGetUser = MockGetUser();
    bloc = UserBloc(mockGetUser);
  });

  test('initial state should be empty', () {
    //assert
    expect(bloc.state, equals(UserEmpty()));
  });

  group('getUser', () {
    final tUser = UserModel.fromJson(json.decode(fixture('user.json')));
    test('should get data from the usecase', () async {
      //arrange
      when(mockGetUser(getUserUseCase.NoParams()))
          .thenAnswer((realInvocation) async => Right(tUser));
      //act
      bloc.add(GetUserEvent());
      await untilCalled(mockGetUser(getUserUseCase.NoParams()));
      //assert
      verify(mockGetUser(getUserUseCase.NoParams()));
    });
    test('should emit [UserLoading, UserLoaded] when data is gotten ', () {
      //arrange
      when(mockGetUser(getUserUseCase.NoParams()))
          .thenAnswer((realInvocation) async => Right(tUser));
      //assert
      final expected = [UserLoading(), UserLoaded(tUser)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetUserEvent());
    });
    test('should emit [UserLoading, UserError] when getting data fails', () {
      // arrange
      when(mockGetUser(getUserUseCase.NoParams()))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));
      // assert
      final expected = [
        UserLoading(),
        UserError("Error obteniendo el usuario")
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserEvent());
    });
  });
}
