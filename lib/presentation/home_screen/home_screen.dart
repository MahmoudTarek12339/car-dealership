import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_dealership/controller/cars_provider.dart';
import 'package:car_dealership/presentation/home_screen/widgets/cars_list_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/search_cars_list_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/search_widgets.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.place_outlined,
                color: ColorManager.black,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Cairo, Egypt',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: ColorManager.black,
              ),
            ],
          ),
          actions: const [
            //user profile picture
            Padding(
              padding: EdgeInsets.only(
                right: 15.0,
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: CachedNetworkImageProvider(
                    'https://i.pinimg.com/originals/3c/59/da/3c59da5f6aefd35919550e9405dc63c4.jpg'),
              ),
            )
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
                      'Hello Mahmoud',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'let\'s find your dream car here',
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
                        'Popular Cars',
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
