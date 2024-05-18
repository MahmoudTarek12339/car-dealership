import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/models/language_model.dart';
import 'package:car_dealership/presentation/home_screen/widgets/cars_list_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/search_cars_list_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/search_widgets.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: ColorManager.white,
          title: Text(
            'Cairo, Egypt',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<Language>(
                underline: const SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: ColorManager.black,
                ),
                items:
                Language.languagesList.map<DropdownMenuItem<Language>>((e) {
                  return DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(e.flag, style: const TextStyle(fontSize: 30)),
                        Text(e.name, style: const TextStyle(fontSize: 24)),
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
            ),
            //user profile picture
            const Padding(
              padding: EdgeInsets.only(
                right: 15.0,
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: CachedNetworkImageProvider(
                    'https://i.pinimg.com/originals/3c/59/da/3c59da5f6aefd35919550e9405dc63c4.jpg'),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.hello,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppLocalizations.of(context)!.findDreamCarHere,
                      style: TextStyle(fontSize: 18, color: ColorManager.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SearchWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                    //to hide it while loading or if failure happened
                    if (!context.read<CarsProvider>().isLoading &&
                        !context.read<CarsProvider>().apiRequestFail)
                      Text(
                        AppLocalizations.of(context)!.popularCars,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.black),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              //here we switch between search and normal cars list
              context.watch<CarsProvider>().searching
                  ? const SearchCarsListWidget()
                  : const CarsListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
