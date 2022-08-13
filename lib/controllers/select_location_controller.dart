import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart' hide Response;
import 'package:nectar/controllers/phone_number_controller.dart';
import 'package:nectar/controllers/sign_up_controller.dart';
import 'package:nectar/models/city.dart';
import 'package:nectar/models/country.dart';

class SelectLocationController extends GetxController {
  var selectedCountryCode = "".obs;
  var country = <Country>[].obs;
  var city = <City>[].obs;
  var selectedCountryName = "".obs;
  var selectedCityName = "".obs;
  SignUpController signUpController = Get.find();
  PhoneNumberController phoneNumberController = Get.find();

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

  signUp() async {
    if (selectedCountryName.value == "") {
      Get.snackbar("Selected country empty", "Please select your country");
    } else if (selectedCityName.value == "") {
      Get.snackbar("Selected city empty", "Please select your city");
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: signUpController.emailController.value.text,
            password: signUpController.passwordController.value.text);

        //success created account;
        var uid = FirebaseAuth.instance.currentUser!.uid;

        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "username": signUpController.usernameController.value.text,
          "email": signUpController.emailController.value.text,
          "phone": phoneNumberController.numberController.value.text,
          "country": selectedCountryName.value,
          "city": selectedCityName.value
        });
        ;
        Get.offAllNamed('/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("The password is too weak");
          Get.snackbar("The password is to weak", "Change password");
        } else if (e.code == 'email-already-in-use') {
          print("The account already exist for that email");
          Get.snackbar("The accoung already exists for that email",
              "Please change email");
        }
      } catch (e) {
        print(e);
        Get.snackbar(e.toString(), e.toString());
      }
    }
  }
}
