import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: ColorManager.white,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorManager.white,
  );
}
