import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api/api_dio.dart';
import 'api/api.dart';
import 'models/hotels_repository.dart';
import 'repository/hotels_repository_data.dart';

class ServiceProvider {
  static final _getIt = GetIt.I;
  T get<T extends Object>() => _getIt.get<T>();

  static final instance = ServiceProvider();

  void initialize() {
    _getIt.registerLazySingleton<Dio>(() => Dio());
    _getIt.registerLazySingleton<Api>(() => ApiDio(_getIt.get<Dio>(), "https://run.mocky.io/v3/"));
    _getIt.registerLazySingleton<HotelsRepository>(
      () => HotelsRepositoryData(_getIt.get<Api>()),
    );
  }
}
