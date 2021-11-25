part of 'api_data_bloc.dart';

abstract class ApiDataEvent extends Equatable {
  const ApiDataEvent();

  @override
  List<Object> get props => [];
}

class GetApiDataEvent extends ApiDataEvent {}
