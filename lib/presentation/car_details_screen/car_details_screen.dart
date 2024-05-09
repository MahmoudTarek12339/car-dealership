import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/car_details_screen/widgets/car_engine_fuel_details_widget.dart';
import 'package:car_dealership/presentation/car_details_screen/widgets/details_car_image_widget.dart';
import 'package:car_dealership/presentation/car_details_screen/widgets/price_and_book_widget.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/car_model.dart';

class CarDetailsScreen extends StatelessWidget {
  final int index;

  const CarDetailsScreen(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    //to switch if user select car from search or normal list
    bool searching = context.read<CarsProvider>().searching;
    final Car car = searching
        ? context.watch<CarsProvider>().result[index]
        : context.watch<CarsProvider>().cars[index];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorManager.black,
            ),
          ),
          title: Text(
            '${car.make} ${car.model} ${car.year}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<CarsProvider>().updateFavorite(car.id);
              },
              icon: Icon(
                car.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: ColorManager.red,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsCarImageWidget(car.image),
                const SizedBox(
                  height: 15,
                ),
                CarEngineAndFuelWidget(car),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  car.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorManager.black,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                PriceAndBookWidget(car),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
