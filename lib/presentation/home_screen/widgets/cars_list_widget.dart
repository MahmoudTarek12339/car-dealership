import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/home_screen/widgets/cars_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsListWidget extends StatelessWidget {
  const CarsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarsProvider>(builder: (_, value, __) {
      //here we used sliver list instead of listview
      // to be able to use custom scroll view
      return SliverList.builder(
        itemBuilder: (context, index) => CarsListItem(value.cars[index], index),
        itemCount: value.cars.length,
      );
    });
  }
}
