import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountriesSelectorDialog extends StatefulWidget {
  const CountriesSelectorDialog({super.key});

  @override
  State<CountriesSelectorDialog> createState() =>
      _CountriesSelectorDialogState();
}

class _CountriesSelectorDialogState extends State<CountriesSelectorDialog> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CarsProvider>();
    return Dialog(
      backgroundColor: ColorManager.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CSCPicker(
              showCities: false,
              dropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: ColorManager.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              countrySearchPlaceholder: "Country",
              stateSearchPlaceholder: "State",
              citySearchPlaceholder: "City",
              countryDropdownLabel: "*Country",
              stateDropdownLabel: "*State",
              cityDropdownLabel: "*City",
              selectedItemStyle: TextStyle(
                color: ColorManager.black,
                fontSize: 14,
              ),
              dropdownHeadingStyle: TextStyle(
                  color: ColorManager.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              dropdownItemStyle: TextStyle(
                color: ColorManager.black,
                fontSize: 14,
              ),
              dropdownDialogRadius: 10.0,
              searchBarRadius: 10.0,
              onCountryChanged: (value) {
                //remove country flag
                var list = value.split(' ');
                list.removeAt(0);
                print(list);
                selectedCountry = list.join(' ').trim();
                setState(() {});
              },
              onStateChanged: (value) {
                selectedState = value ?? '';
                setState(() {});
              },
              onCityChanged: (value) {
                //remove governerate word from selected city string
                selectedCity = value ?? '';
                setState(() {});
              },
              layout: Layout.vertical,
              disabledDropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: ColorManager.grey,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _isAllSet
                  ? () async {
                      await controller.setMyCountry(
                        context,
                        selectedCountry ?? '',
                        selectedCity ?? '',
                      );
                      //close country selector dialog
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  : null,
              style:
                  ElevatedButton.styleFrom(backgroundColor: ColorManager.black),
              child: Text(
                AppLocalizations.of(context)!.select,
                style: TextStyle(color: ColorManager.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //disable button if ant of country data not selected
  bool get _isAllSet => (selectedCity != null ||
      selectedState != null ||
      selectedCountry != null);
}
