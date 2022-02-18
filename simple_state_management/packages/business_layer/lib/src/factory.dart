import 'package:data_layer/data_layer.dart';
import 'package:get_it/get_it.dart';

import 'models/hotels_notifier.dart';
import 'notifiers/hotels_state.dart';


class ProvidersFactory {
  static final _getIt = GetIt.I;
  T get<T extends Object>() => _getIt.get<T>();

  static final instance = ProvidersFactory();

  void initialize() {
    ServiceProvider.instance.initialize();
    _getIt.registerFactory<HotelsNotifier>(
          () => HotelsState(_getIt.get<HotelsRepository>()),
    );
  }
}