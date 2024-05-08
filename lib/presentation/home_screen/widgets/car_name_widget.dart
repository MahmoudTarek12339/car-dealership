import 'package:car_dealership/models/car_model.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class CarNameWidget extends StatelessWidget {
  final Car car;

  const CarNameWidget(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        '${car.make} ${car.model} ${car.year}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: ColorManager.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
