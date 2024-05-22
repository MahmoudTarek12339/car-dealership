import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/cars_provider.dart';
import '../../../models/language_model.dart';
import '../../resources/color_manager.dart';

class ChangeLanguageIconWidget extends StatelessWidget {
  const ChangeLanguageIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: DropdownButton<Language>(
        underline: const SizedBox.shrink(),
        icon: Icon(
          Icons.language,
          color: ColorManager.black,
        ),

        items: Language.languagesList.map<DropdownMenuItem<Language>>((e) {
          return DropdownMenuItem<Language>(
            value: e,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(e.name, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Text(e.flag, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        }).toList(),
        onChanged: (Language? language) {
          context
              .read<CarsProvider>()
              .changeLanguage(Locale(language!.languageCode));
        },
      ),
    );
  }
}
