import 'package:car_dealership/controller/cars_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/color_manager.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarsProvider>(
      builder: (_, value, __) {
        return Container(
          padding: const EdgeInsets.all(5.0),
          width: double.infinity,
          height: 110,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.getCurrentLocation,
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () async {
                  value.isLoadingCountry = true;
                  value.showLoadingDialog(context);
                  await value.getMyCountry().then((_) {
                    Navigator.of(context).pop();
                    value.isLoadingCountry = false;
                    value.closeBottomSheet();
                  }).catchError((error) {
                    Navigator.of(context).pop();
                    value.isLoadingCountry = false;
                    value.closeBottomSheet();
                  });
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.selectLocationManually,
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {
                  value.showCountriesSelectorDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
