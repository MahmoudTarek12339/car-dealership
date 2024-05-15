import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/home_screen/widgets/cars_list_item.dart';
import 'package:car_dealership/presentation/home_screen/widgets/no_internet_widget.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsListWidget extends StatelessWidget {
  const CarsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarsProvider>(builder: (_, value, __) {
      //here we used sliver list instead of listview
      // to be able to use custom scroll view

      if (value.isLoading) {
        //loading while fetching data
        return SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorManager.green,
              ),
            ),
          ),
        );
      } else if (value.apiRequestFail) {
        // if request failed or internet connection failure
        return const NoInternetWidget();
      } else {
        // if request successfully get data
        return SliverList.builder(
          itemBuilder: (context, index) =>
              CarsListItem(value.cars[index], index),
          itemCount: value.cars.length,
        );
      }
    });
  }
}
