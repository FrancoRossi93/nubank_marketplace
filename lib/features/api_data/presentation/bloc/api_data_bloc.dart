import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/features/api_data/domain/entities/api_data.dart';
import 'package:nubank_marketplace/features/api_data/domain/usecases/get_api_data.dart'
    as getApiDataUseCase;

part 'api_data_event.dart';
part 'api_data_state.dart';

class ApiDataBloc extends Bloc<ApiDataEvent, ApiDataState> {
  final getApiDataUseCase.GetApiData getApiData;
  ApiDataBloc(this.getApiData) : super(ApiDataEmpty());
  @override
  Stream<ApiDataState> mapEventToState(ApiDataEvent event) async* {
    if (event is GetApiDataEvent) {
      yield ApiDataLoading();
      final failureOrUser = await getApiData(getApiDataUseCase.NoParams());
      yield failureOrUser.fold(
          (l) => ApiDataError(l?.message), (r) => ApiDataLoaded(r));
    }
  }
}
