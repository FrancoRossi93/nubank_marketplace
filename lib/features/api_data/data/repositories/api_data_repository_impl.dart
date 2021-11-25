import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/failures.dart';

import 'package:nubank_marketplace/core/network/network_info.dart';
import 'package:nubank_marketplace/features/api_data/data/datasources/api_data_remote_source.dart';
import 'package:nubank_marketplace/features/api_data/domain/entities/api_data.dart';
import 'package:nubank_marketplace/features/api_data/domain/repository/api_data_repository.dart';

class ApiDataRepositoryImpl implements ApiDataRepository {
  final ApiDataRemoteSource remoteSource;
  final NetworkInfo networkInfo;

  ApiDataRepositoryImpl(
      {@required this.remoteSource, @required this.networkInfo});

  @override
  Future<Either<Failure, ApiData>> getApiData() async {
    if (await networkInfo.isConnected) {
      try {
        ApiData apiData = await remoteSource.getApiData();
        return Right(apiData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
