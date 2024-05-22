import 'dart:convert';
import 'package:car_dealership/presentation/home_screen/widgets/bottom_sheet_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/countries_selector_dialog.dart';
import 'package:car_dealership/presentation/home_screen/widgets/loading_dialog_widget.dart';
import 'package:car_dealership/presentation/resources/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_data/country_data.dart';
import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:directus/directus.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
    //initialize shared Preferences instances
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
      //get saved application language
      _loadLocale().then((value) => getCars());

      //get saved favorites
      _getFavoritesFromSharedPreferences();
      //get saved currency data
      _getSavedCurrency();
      //get saved country data
      _getSavedCountryDetails();

      _getConvertedPrice();
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

      //here we switch to get matched api collection data
      //according to app language
      late String collectionName;
      switch (_locale.languageCode) {
        case 'en':
          collectionName = 'cars';
          break;
        case 'ar':
          collectionName = 'cars_ar';
          break;
        case 'es':
          collectionName = 'cars_es';
          break;
        case 'fr':
          collectionName = 'cars_fr';
          break;
        default:
          collectionName = 'cars';
          break;
      }

      //initialize directus sdk
      await Directus(AppConstants.baseUrl).init().then((sdk) {
        //after sdk initialized
        //retrieve data from cars collection
        sdk.items(collectionName).readMany().then((res) {
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

  _getFavoritesFromSharedPreferences() async {
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

  //searching
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

  ///----------Localization--------------
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> changeLanguage(Locale locale) async {
    _locale = locale;
    await getCars();
    await _preferences.setString('selected_locale', locale.languageCode);
    notifyListeners();
  }

  Future<void> _loadLocale() async {
    final localeCode = _preferences.getString('selected_locale') ?? 'en';
    _locale = Locale(localeCode);
    notifyListeners();
  }

  ///----------multi currency--------------
  late String _myCurrencyKey;
  late Currency _myCurrency;

  late String _country;

  String get country => _country;

  double priceConvertFactor = 1;

  Future<void> getMyCountry() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    // Check for location permissions
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get the place details
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks[0];

      String country = place.country ?? 'Egypt';
      String city = place.administrativeArea?.split(' ').first ?? 'Cairo';
      _country = '$city, $country';
      notifyListeners();
      // Get the country currency
      await _getCountryCurrency(country);
      //update currency price rate
      await _getConvertedPrice();
      //save currency to shared pref
      await _saveCurrency();
      //save country Details to shared pref
      await _saveCountryDetails();
    }
    notifyListeners();
  }

  Future<void> setMyCountry(
      BuildContext context, String country, String city) async {
    notifyListeners();
    isLoadingCountry = true;
    _country = '$city, $country';
    showLoadingDialog(context);
    //get Currency of selected country
    await _getCountryCurrency(country.toLowerCase())
        .catchError((onError) async {
      isLoadingCountry = false;
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
    //update currency price rate
    await _getConvertedPrice();
    //save currency to shared pref
    await _saveCurrency();
    //save country Details to shared pref
    await _saveCountryDetails();
    closeBottomSheet();
  }

  //get price conversion rate from egp to selected country currency
  Future<void> _getConvertedPrice() async {
    double? convertedPrice;
    convertedPrice = await CurrencyConverter.convert(
      from: Currency.egp,
      to: _myCurrency,
      amount: 1.0,
    );
    priceConvertFactor = convertedPrice ?? 1.0;
  }

  Future<void> _getCountryCurrency(String country) async {
    //get currency code of country
    String currency = CountryData()
        .getCountries()
        .where((element) => element.name.toLowerCase() == country.toLowerCase())
        .first
        .currencyCode;
    _myCurrencyKey = currency;
    Currency myCurrency = Currency.values.firstWhere(
      (e) =>
          e.toString().split('.').last.toLowerCase() ==
          _myCurrencyKey.toLowerCase(),
      orElse: () => Currency.usd,
    );
    _myCurrency = myCurrency;
  }

  Future<void> _saveCurrency() async {
    await _preferences.setString('my_currency_key', _myCurrencyKey);
  }

  Future<void> _getSavedCurrency() async {
    _myCurrencyKey = _preferences.getString('my_currency_key') ?? 'egp';
    Currency myCurrency = Currency.values.firstWhere(
      (e) =>
          e.toString().split('.').last.toLowerCase() ==
          _myCurrencyKey.toLowerCase(),
      orElse: () => Currency.usd,
    );
    _myCurrency = myCurrency;
  }

  Future<void> _saveCountryDetails() async {
    await _preferences.setString('country', _country);
  }

  Future<void> _getSavedCountryDetails() async {
    _country = _preferences.getString('country') ?? 'Cairo,Egypt';
  }

  //home bottom sheet
  bool isBottomSheetOpen = false;

  late PersistentBottomSheetController _controller;

  void toggleBottomSheet(BuildContext context) {
    if (isBottomSheetOpen) {
      closeBottomSheet();
    } else {
      _controller = Scaffold.of(context).showBottomSheet(
        (context) {
          return const BottomSheetWidget();
        },
      );
      isBottomSheetOpen = true;
      _controller.closed.then((value) {
        isBottomSheetOpen = false;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  void closeBottomSheet() {
    _controller.close();
    isBottomSheetOpen = false;
    notifyListeners();
  }

  bool isLoadingCountry = false;

  // show loading dialog while getting current location
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialogWidget();
      },
    );
  }

  // show dialog to pick country and city data
  void showCountriesSelectorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const CountriesSelectorDialog();
      },
    );
    notifyListeners();
  }
}
