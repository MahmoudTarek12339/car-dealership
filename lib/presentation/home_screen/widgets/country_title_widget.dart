import 'package:car_dealership/controller/cars_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';

class CountryTitleWidget extends StatelessWidget {
  const CountryTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CarsProvider>().toggleBottomSheet(context);
      },
      child: Text(
        context.watch<CarsProvider>().country,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
