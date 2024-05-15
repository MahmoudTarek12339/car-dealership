import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Lottie.asset(LottieAssets.noInternet),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Oops!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Something Went Wrong,',
            style: TextStyle(
              fontSize: 16,
              color: ColorManager.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Please Check Your Internet Connection',
            style: TextStyle(
              fontSize: 16,
              color: ColorManager.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CarsProvider>().getCars();
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: ColorManager.green),
            child: Text(
              'Try Again',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
