import 'package:car_dealership/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/color_manager.dart';

class NoInternetWidget extends StatelessWidget {
  final Function() onPressed;
  const NoInternetWidget({required this.onPressed,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(LottieAssets.noInternet),
        const SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context)!.oops,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: ColorManager.black,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context)!.someThingWentWrong,
          style: TextStyle(
            fontSize: 16,
            color: ColorManager.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          AppLocalizations.of(context)!.pleaseCheckConnection,
          style: TextStyle(
            fontSize: 16,
            color: ColorManager.black,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style:
              ElevatedButton.styleFrom(backgroundColor: ColorManager.green),
          child: Text(
            AppLocalizations.of(context)!.tryAgain,
            style: TextStyle(
              fontSize: 16,
              color: ColorManager.black,
            ),
          ),
        )
      ],
    );
  }
}
