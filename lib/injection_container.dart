import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:nubank_marketplace/core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:nubank_marketplace/core/utils/token.dart';
import 'package:nubank_marketplace/features/offers/data/datasources/offers_remote_data_source.dart';
import 'package:nubank_marketplace/features/offers/data/repositories/offers_repository_impl.dart';
import 'package:nubank_marketplace/features/offers/domain/repository/offers_repository.dart';
import 'package:nubank_marketplace/features/offers/domain/usecases/get_offers.dart';
import 'package:nubank_marketplace/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:nubank_marketplace/features/user/data/datasources/user_remote_data_source.dart';
import 'package:nubank_marketplace/features/user/data/repositories/user_repository_impl.dart';
import 'package:nubank_marketplace/features/user/domain/repository/user_repository.dart';
import 'package:nubank_marketplace/features/user/domain/usecases/get_user.dart';
import 'package:nubank_marketplace/features/user/presentation/bloc/user_bloc.dart';

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
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<OffersRepository>(
      () => OffersRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //!Blocs
  sl.registerLazySingleton(() => UserBloc(sl()));
  sl.registerLazySingleton(() => OffersBloc(sl()));

  // Usercases
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => GetOffers(sl()));

  // Datasources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton<OffersRemoteDataSource>(
      () => OffersRemoteDataSourceImpl(sl(), sl()));
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
