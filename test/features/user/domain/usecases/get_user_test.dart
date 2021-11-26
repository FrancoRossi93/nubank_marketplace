import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';
import 'package:nubank_marketplace/features/user/domain/repository/user_repository.dart';
import 'package:nubank_marketplace/features/user/domain/usecases/get_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  GetUser usecase;
  MockUserRepository repository;

  setUp(() {
    repository = MockUserRepository();
    usecase = GetUser(repository);
  });

  final tUser = User(id: "1", name: "Test name", balance: 1000);

  test('should get user from repository', () async {
    //arrange
    when(repository.getUser())
        .thenAnswer((realInvocation) async => Right(tUser));
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, equals(Right(tUser)));
    verify(repository.getUser());
    verifyNoMoreInteractions(repository);
  });
}
