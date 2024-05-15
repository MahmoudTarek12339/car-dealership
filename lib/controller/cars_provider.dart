import 'dart:convert';

import 'package:car_dealership/presentation/resources/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:directus/directus.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/car_model.dart';

class CarsProvider with ChangeNotifier {
  late SharedPreferences _preferences;

  List<Car> cars = [];

  List<Car> result = [];

  List<int> favorites = [];

  bool searching = false;

  bool isLoading = false;

  bool apiRequestFail = false;

  CarsProvider() {
    getCars();
    //initialize shared Preferences instances
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
      getFavoritesFromSharedPreferences();
    });
  }

  // Check the internet connection status
  Future<bool> checkConnection() async {
    List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
  }

  //retrieve cars data from directus server
  getCars() async {
    //check internet connectivity
    bool internetConnected = await checkConnection();
    if (!internetConnected) {
      //case no internet connection

      apiRequestFail = true;
      notifyListeners();
    } else {
      //case connected to internet

      isLoading = true;
      apiRequestFail = false;
      notifyListeners();

      //initialize directus sdk
      await Directus(AppConstants.baseUrl).init().then((sdk) {
        //after sdk initialized
        //retrieve data from cars collection
        sdk.items('cars').readMany().then((res) {
          List<Car> responses =
              res.data.map((car) => Car.fromJson(car)).toList();
          cars.clear();
          cars.addAll(responses);
          notifyListeners();
        }).catchError((error) {
          apiRequestFail = true;
          notifyListeners();
        });
      }).catchError((onError) {
        apiRequestFail = true;
        notifyListeners();
      });
      isLoading = false;
    }
  }

  updateFavorite(int id) async {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    updateFavoritesSharedPreferences();
    notifyListeners();
  }

  updateFavoritesSharedPreferences() async {
    //save favorites list to shared pref
    String favoritesJson = jsonEncode(favorites);
    await _preferences.setString(
        AppConstants.favoritesSharedPrefKey, favoritesJson);
    notifyListeners();
  }

  getFavoritesFromSharedPreferences() async {
    //retrieve saved favorites list from shared pref

    String? favoritesJson =
        _preferences.getString(AppConstants.favoritesSharedPrefKey);
    if (favoritesJson != null) {
      List<int> data = jsonDecode(favoritesJson).cast<int>();
      favorites.addAll(data);
    }
    notifyListeners();
  }

  bool isFavorite(int id) => favorites.contains(id);

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
