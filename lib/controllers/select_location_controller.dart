import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:nectar/models/city.dart';
import 'package:nectar/models/country.dart';

class SelectLocationController extends GetxController {
  var selectedCountryCode = "".obs;
  var country = <Country>[].obs;
  var city = <City>[].obs;
  var selectedCountryName = "".obs;
  var selectedCityName = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Response response;
    var dio = Dio();
    response = await dio.get(
        "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?offset=60",
        options: Options(headers: {
          "X-RapidAPI-Key":
              "4602013230msh9701492263a7731p154bebjsn8607685bc37e",
          "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com",
        }));
    List<dynamic> data = response.data["data"];
    country.value = data.map((json) {
      return Country.fromJson(json);
    }).toList();
    print(country[0].name);
  }

  getCities(String value) async {
    Response response;
    var dio = Dio();
    response = await dio.get(
        "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?offset=100",
        queryParameters: {"countryIds": selectedCountryCode.value},
        options: Options(
          headers: {
            'X-RapidAPI-Key':
                '4602013230msh9701492263a7731p154bebjsn8607685bc37e',
            'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com'
          },
        ));
    List<dynamic> data = response.data["data"];
    city.value = data.map((json) {
      return City.fromJson(json);
    }).toList();
  }

  changeSelectedCountryCode(String value) {
    selectedCountryCode.value = value;
  }

  changeSelectedCountryName(String value) {
    selectedCountryName.value = value;
  }

  changeSelectedCityName(String value) {
    selectedCityName.value = value;
  }
}
