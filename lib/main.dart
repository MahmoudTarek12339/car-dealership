import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/resources/routes_manager.dart';
import 'package:car_dealership/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CarsProvider()..initMakers(),
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getAppTheme(),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
          );
        });
  }
}
