import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/home_screen/widgets/cars_list_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/change_language_icon_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/country_title_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/search_cars_list_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/search_widgets.dart';
import 'package:car_dealership/presentation/home_screen/widgets/user_profile_widget.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
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
          backgroundColor: ColorManager.white,
          leading: const UserProfileWidget(),
          title: const CountryTitleWidget(),
          leadingWidth: 45.0,
          titleSpacing: 0.0,
          actions: const [ChangeLanguageIconWidget()],
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
