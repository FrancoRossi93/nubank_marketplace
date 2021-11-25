import 'package:dartz/dartz.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
}
