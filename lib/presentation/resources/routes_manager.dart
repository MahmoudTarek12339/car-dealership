import 'package:car_dealership/presentation/car_details_screen/car_details_screen.dart';
import 'package:car_dealership/presentation/home_screen/home_screen.dart';
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
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.carDetails:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        int index = arguments['index'] as int;
        return MaterialPageRoute(builder: (_) => CarDetailsScreen(index));
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
