import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:nubank_marketplace/core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:nubank_marketplace/core/utils/token.dart';
import 'package:nubank_marketplace/features/api_data/data/datasources/api_data_remote_source.dart';
import 'package:nubank_marketplace/features/api_data/data/repositories/api_data_repository_impl.dart';
import 'package:nubank_marketplace/features/api_data/domain/repository/api_data_repository.dart';
import 'package:nubank_marketplace/features/api_data/domain/usecases/get_api_data.dart';
import 'package:nubank_marketplace/features/api_data/presentation/bloc/api_data_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  await initExternal();
  //! Features
  initFeatures();
  //! Core
  initCore();
}

void initFeatures() {
  //!Repositories
  sl.registerLazySingleton<ApiDataRepository>(
      () => ApiDataRepositoryImpl(remoteSource: sl(), networkInfo: sl()));
  //!Blocs
  sl.registerLazySingleton(() => ApiDataBloc(sl()));
  // Usercases
  sl.registerLazySingleton(() => GetApiData(sl()));
  // Datasources
  sl.registerLazySingleton<ApiDataRemoteSource>(
      () => ApiDataRemoteSourceImpl(client: sl(), tokenHelper: sl()));
}

void initCore() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

Future<void> initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => TokenHelper());
}
