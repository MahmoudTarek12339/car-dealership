import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/models/car_model.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatelessWidget {
  final Car car;
  final int index;

  const FavoriteWidget(this.car, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: IconButton(
        onPressed: () {
          context.read<CarsProvider>().updateFavorite(car.id);
        },
        icon: Icon(
          car.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: ColorManager.red,
        ),
      ),
    );
  }
}
