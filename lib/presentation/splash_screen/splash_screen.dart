import 'package:car_dealership/presentation/resources/assets_manager.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:car_dealership/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.splash),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find your ideal Car',
                style: TextStyle(
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Get access to the best deals from global cars companies',
                style: TextStyle(
                  color: ColorManager.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.homeRoute);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.green),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
