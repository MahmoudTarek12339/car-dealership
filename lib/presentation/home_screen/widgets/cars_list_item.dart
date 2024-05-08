import 'package:car_dealership/presentation/home_screen/widgets/car_image_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/favorite_widget.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../models/car_model.dart';
import '../../resources/routes_manager.dart';
import 'car_name_widget.dart';

class CarsListItem extends StatelessWidget {
  final Car car;
  final int index;

  const CarsListItem(this.car, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: InkWell(
        onTap: () {
          //pass index argument to details screen
          Navigator.pushNamed(context, Routes.carDetails,
              arguments: {'index': index});
        },
        child: SizedBox(
          height: 200,
          child: Card(
            elevation: 10,
            color: ColorManager.white,
            shadowColor: ColorManager.lightBlack,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Column(
                    children: [
                      CarImageWidget(car.image),
                      CarNameWidget(car),
                    ],
                  ),
                  FavoriteWidget(car, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
