import 'package:dartz/dartz.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/features/init_settings/domain/entities/api_data.dart';

abstract class InitSettingsRepository {
  Future<Either<Failure, ApiData>> getApiData();
}
