import 'package:flutter/material.dart';

import '../models/car_model.dart';

class CarsProvider with ChangeNotifier {
  List<Car> cars = [
    Car(
      1,
      'Corolla',
      'Toyota',
      2015,
      25000.00,
      'Great condition, low mileage.',
      'Available',
      'https://i.pinimg.com/564x/44/24/f7/4424f727151ce18da61c6664fb22592f.jpg',
      '140 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      2,
      'Civic',
      'Honda',
      2018,
      28500.00,
      'Used, but well-maintained.',
      'Sold',
      'https://i.pinimg.com/564x/f0/ae/cb/f0aecbe53189118c2e76a0a4a1e3767f.jpg',
      '158 hp',
      'Manual',
      'Gasoline',
      false,
    ),
    Car(
      5,
      '3 Series',
      'BMW',
      2017,
      42000.00,
      'Luxurious interior with advanced features.',
      'Sold',
      'https://i.pinimg.com/564x/94/ae/93/94ae93dc5587494588a222687bfe2de5.jpg',
      '248 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      6,
      'C-Class',
      'Mercedes-Benz',
      2014,
      38500.00,
      'Spacious and comfortable for long drives.',
      'Available',
      'https://i.pinimg.com/originals/47/8b/f6/478bf61e4712ba383a76118a6558bfd4.jpg',
      '241 hp',
      'Automatic',
      'Diesel',
      false,
    ),
    Car(
      7,
      'A4',
      'Audi',
      2019,
      46000.00,
      'Efficient and reliable for daily commute.',
      'Reserved',
      'https://i.pinimg.com/564x/c5/e2/4e/c5e24eab84569e0f0baf5eeedad31306.jpg',
      '188 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      8,
      'Altima',
      'Nissan',
      2012,
      20500.00,
      'Sleek design with excellent handling.',
      'Available',
      'https://i.pinimg.com/564x/c7/dd/6d/c7dd6d849d74c9b28adb5185afd6a2c9.jpg',
      '270 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      9,
      'Golf',
      'Volkswagen',
      2016,
      24700.00,
      'Powerful engine with smooth acceleration.',
      'Sold',
      'https://i.pinimg.com/originals/01/f4/e6/01f4e6cf6096627bbb76a7d54e8fe5ce.png',
      '170 hp',
      'Manual',
      'Diesel',
      false,
    ),
    Car(
      10,
      'Model S',
      'Tesla',
      2018,
      68000.00,
      'Cutting-edge technology for a futuristic driving experience.',
      'Available',
      'https://i.pinimg.com/originals/75/2b/45/752b4513ec590be940f88c64276e5051.jpg',
      '518 hp',
      'Automatic',
      'Electric',
      false,
    ),
    Car(
      11,
      'Accord',
      'Honda',
      2014,
      27000.00,
      'Well-maintained with comfortable interior.',
      'Available',
      'https://i.pinimg.com/originals/f0/ae/cb/f0aecbe53189118c2e76a0a4a1e3767f.jpg',
      '185 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      12,
      'Camry',
      'Toyota',
      2016,
      32000.00,
      'Reliable and efficient for daily commuting.',
      'Sold',
      'https://i.pinimg.com/564x/ed/9c/c3/ed9cc32da39521b2a16377728fa04617.jpg',
      '203 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      14,
      'Impala',
      'Chevrolet',
      2017,
      35000.00,
      'Comfortable ride with spacious interior.',
      'Reserved',
      'https://i.pinimg.com/564x/a6/71/d3/a671d3ed460c7333b99959cd379806c3.jpg',
      '197 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      16,
      'E-Class',
      'Mercedes-Benz',
      2016,
      55000.00,
      'Executive sedan with premium features and comfort.',
      'Sold',
      'https://i.pinimg.com/originals/47/8b/f6/478bf61e4712ba383a76118a6558bfd4.jpg',
      '329 hp',
      'Automatic',
      'Diesel',
      false,
    ),
    Car(
      17,
      'A6',
      'Audi',
      2015,
      48000.00,
      'Sophisticated design with powerful performance.',
      'Available',
      'https://i.pinimg.com/originals/2f/d1/5f/2fd15f5a819f82b303d44b22ead2a0e0.jpg',
      '252 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      18,
      'Maxima',
      'Nissan',
      2018,
      33000.00,
      'Sporty sedan with dynamic driving characteristics.',
      'Reserved',
      'https://i.pinimg.com/564x/9c/19/5a/9c195abe461c636a6af73b0a5e2c8076.jpg',
      '300 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      19,
      'Jetta',
      'Volkswagen',
      2013,
      19500.00,
      'Compact car with agile handling and spacious interior.',
      'Available',
      'https://i.pinimg.com/564x/36/9e/34/369e344723343d756e3930da62e3e484.jpg',
      '147 hp',
      'Manual',
      'Gasoline',
      false,
    ),
    Car(
      21,
      'Rav4',
      'Toyota',
      2018,
      32000.00,
      'Compact SUV with versatility and reliability.',
      'Sold',
      'https://i.pinimg.com/564x/89/e0/f1/89e0f11904385c2d108c6602089cc8b4.jpg',
      '203 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      22,
      'CR-V',
      'Honda',
      2017,
      29000.00,
      'Popular SUV known for its spacious interior and fuel efficiency.',
      'Available',
      'https://i.pinimg.com/736x/ad/7c/fa/ad7cfacd74e9dd1a326353e7ad12a2a0.jpg',
      '190 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      23,
      'Escape',
      'Ford',
      2019,
      34000.00,
      'Compact SUV with sporty handling and advanced technology.',
      'Reserved',
      'https://i.pinimg.com/564x/be/d6/a5/bed6a5a08b87bf369eff2afe22e331cb.jpg',
      '245 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      24,
      'Equinox',
      'Chevrolet',
      2015,
      28000.00,
      'Practical SUV with comfortable ride and fuel-efficient engine.',
      'Available',
      'https://i.pinimg.com/564x/af/25/57/af2557e7aaee35084fcc311e20a35391.jpg',
      '170 hp',
      'Automatic',
      'Diesel',
      false,
    ),
    Car(
      25,
      'X3',
      'BMW',
      2018,
      52000.00,
      'Luxury compact SUV with refined interior and strong performance.',
      'Sold',
      'https://i.pinimg.com/564x/84/4e/5c/844e5ce494cd6c6f6a34d7c64d5fd350.jpg',
      '248 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    //image need to be edited
    Car(
      3,
      'F-150',
      'Ford',
      2013,
      32000.00,
      'Brand new, just off the lot.',
      'Reserved',
      'https://i.pinimg.com/originals/91/50/d7/9150d743a092e5c4396b74855258fba1.jpg',
      '325 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      4,
      'Silverado',
      'Chevrolet',
      2016,
      35800.00,
      'High performance with low fuel consumption.',
      'Available',
      'https://i.pinimg.com/564x/32/e2/3f/32e23f72d550f3ec91296d9e357d0370.jpg',
      '285 hp',
      'Automatic',
      'Diesel',
      false,
    ),
    Car(
      13,
      'Mustang',
      'Ford',
      2015,
      38000.00,
      'Iconic American muscle car with powerful performance.',
      'Available',
      'https://i.pinimg.com/564x/f1/5b/76/f15b7614eb76bdc6e8b0dbb98b6d38ca.jpg',
      '310 hp',
      'Manual',
      'Gasoline',
      false,
    ),
    Car(
      15,
      'X5',
      'BMW',
      2019,
      62000.00,
      'Luxury SUV with advanced technology and performance.',
      'Available',
      'https://i.pinimg.com/564x/8e/5c/c4/8e5cc41b5dac765ebc40db0bec76b67d.jpg',
      '335 hp',
      'Automatic',
      'Gasoline',
      false,
    ),
    Car(
      20,
      'Model 3',
      'Tesla',
      2020,
      55000.00,
      'Electric sedan with long-range capability and advanced features.',
      'Available',
      'https://i.pinimg.com/736x/00/5c/5a/005c5abf3641204e4694bc38c29084bc.jpg',
      '346 hp',
      'Automatic',
      'Electric',
      false,
    ),
  ];


  List<Car> result = [];

  bool searching = false;

  updateFavorite(int id) {
    int index=cars.indexWhere((element) => element.id==id);
    cars[index].changeFavorite();
    notifyListeners();
  }

  searchCar(String query) {
    if (query.isEmpty) {
      searching = false;
      result.clear();
    } else {
      searching = true;
      result = cars
          .where((element) =>
              element.make.toLowerCase().startsWith(query.toLowerCase()) ||
              element.model.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
