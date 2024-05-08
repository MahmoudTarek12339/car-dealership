import 'package:car_dealership/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String carDetails = "/details";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      /*case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.carDetails:
        return MaterialPageRoute(builder: (_) => const SplashView());*/
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('No Route Found'),
              ),
              body: const Center(child: Text('No Route Found')),
            ));
  }
}
/*Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        String ingredients = arguments['ingredients'] as String;*/
