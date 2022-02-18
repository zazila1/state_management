import 'package:business_layer/business_layer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/fluro_router.dart';

void main() {
  AppRouter.init();
  ProvidersFactory.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HotelsNotifier>(
              create: (context) => ProvidersFactory.instance.get<HotelsNotifier>(),),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: AppRouter.startRoute,
          onGenerateRoute: AppRouter.router.generator,
        ),);
  }
}
