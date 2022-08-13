import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberController extends GetxController {
  var selectedCountry = "".obs;
  var numberController = TextEditingController().obs;
  changeSelectedCountry(String value) {
    selectedCountry.value = value;
  }
}
