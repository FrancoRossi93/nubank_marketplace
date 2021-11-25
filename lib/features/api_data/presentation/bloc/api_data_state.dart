part of 'api_data_bloc.dart';

abstract class ApiDataState extends Equatable {
  const ApiDataState();

  @override
  List<Object> get props => [];
}

class ApiDataInitial extends ApiDataState {}

class ApiDataEmpty extends ApiDataState {}

class ApiDataLoading extends ApiDataState {}

class ApiDataError extends ApiDataState {
  final String errorMessage;
  ApiDataError(this.errorMessage);
}

class ApiDataLoaded extends ApiDataState {
  final ApiData apiData;
  ApiDataLoaded(this.apiData);
}
