import 'package:dartz/dartz.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/features/api_data/domain/entities/api_data.dart';

abstract class ApiDataRepository {
  Future<Either<Failure, ApiData>> getApiData();
}
