import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/core/usecases/usecase.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';
import 'package:nubank_marketplace/features/user/domain/repository/user_repository.dart';

class GetUser implements UseCase<User, NoParams> {
  final UserRepository repository;
  GetUser(this.repository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
