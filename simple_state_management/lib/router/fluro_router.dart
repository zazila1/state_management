// 📦 Package imports:
import 'package:animations/animations.dart';
import 'package:fluro/fluro.dart';

// 🌎 Project imports:
import "route_handlers.dart";

class AppRouter {
  static FluroRouter router = FluroRouter();
  static final String startRoute = Routes.home;

  static void init() {
    Routes.configureRoutes(router);
  }
}

class Routes {
  static String home = "/";
  static String hotelDetails = "/albumDetails";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (context, params) {
      return;
    });

    router.define(home, handler: homeHandler, transitionType: TransitionType.native);
    router.define(
      hotelDetails,
      handler: hotelDetailsHandler,
      transitionType: TransitionType.custom,
      transitionDuration: const Duration(milliseconds: 800),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      },
    );
  }
}
