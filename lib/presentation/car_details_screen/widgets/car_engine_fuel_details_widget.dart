import 'package:car_dealership/presentation/car_details_screen/widgets/car_engine_item.dart';
import 'package:flutter/material.dart';

import '../../../models/car_model.dart';

class CarEngineAndFuelWidget extends StatelessWidget {
  final Car car;

  const CarEngineAndFuelWidget(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CarEngineItem(
            'Engine',
            car.engine,
            Icons.speed,
          ),
        ),
        Expanded(
          child: CarEngineItem(
            'Transmission',
            car.transmission,
            Icons.rv_hookup,
          ),
        ),
        Expanded(
          child: CarEngineItem(
            'Fuel Type',
            car.fuelType,
            Icons.local_gas_station,
          ),
        ),
      ],
    );
  }
}
