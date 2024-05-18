import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/home_screen/widgets/cars_list_item.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchCarsListWidget extends StatelessWidget {
  const SearchCarsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarsProvider>(builder: (_, value, __) {
      //here we used sliver list instead of listview
      // to be able to use custom scroll view
      if (value.result.isEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.noResultFound,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.green,
                  fontSize: 32,
                ),
              ),
            ),
          ),
        );
      }
      return SliverList.builder(
        itemBuilder: (context, index) =>
            CarsListItem(value.result[index], index),
        itemCount: value.result.length,
      );
    });
  }
}
