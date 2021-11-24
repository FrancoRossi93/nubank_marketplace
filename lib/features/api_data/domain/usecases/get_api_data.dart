import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/core/failures.dart';
import 'package:nubank_marketplace/core/usecases/usecase.dart';
import 'package:nubank_marketplace/features/api_data/domain/entities/api_data.dart';
import 'package:nubank_marketplace/features/api_data/domain/repository/api_data_repository.dart';

class GetApiData implements UseCase<ApiData, NoParams> {
  final ApiDataRepository repository;
  GetApiData(this.repository);
  @override
  Future<Either<Failure, ApiData>> call(NoParams params) async {
    return await repository.getApiData();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
