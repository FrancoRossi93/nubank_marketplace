import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/failures.dart';

import 'package:nubank_marketplace/core/network/network_info.dart';
import 'package:nubank_marketplace/features/user/data/datasources/user_local_data_source.dart';

import 'package:nubank_marketplace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';
import 'package:nubank_marketplace/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, User>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        await localDataSource.cacheUserToken();
        User user = await remoteDataSource.getUser();
        if (user is User) {
          return Right(user);
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }
  }
}
