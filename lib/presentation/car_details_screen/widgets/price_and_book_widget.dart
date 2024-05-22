import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/models/car_model.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PriceAndBookWidget extends StatelessWidget {
  final Car car;

  const PriceAndBookWidget(this.car, {super.key});

  @override
  Widget build(BuildContext context) {
    final double priceConversionFactor =
        context.read<CarsProvider>().priceConvertFactor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.totalPrice),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${car.price * priceConversionFactor}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
        ElevatedButton(
          //here i used localized value instead of constant value cause
          //this condition vary according to api data language
          onPressed: car.status != AppLocalizations.of(context)!.available
              ? null
              : () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              disabledBackgroundColor: ColorManager.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text(
            car.status == AppLocalizations.of(context)!.available
                ? AppLocalizations.of(context)!.bookNow
                : car.status,
            style: TextStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
