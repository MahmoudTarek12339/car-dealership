import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
          onChanged: (value) {
            context.read<CarsProvider>().searchCar(value);
          },
          onSubmitted: (value) {
            context.read<CarsProvider>().searchCar(value);
          },
          decoration: InputDecoration(
            fillColor: ColorManager.grey,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search),
            hintText: AppLocalizations.of(context)!.searchYourCar,
            hintStyle: TextStyle(
              color: ColorManager.lightBlack,
            ),
          )),
    );
  }
}
