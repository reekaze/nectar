import 'package:get/get.dart';

class PhoneNumberController extends GetxController {
  var selectedCountry = "".obs;
  changeSelectedCountry(String value) {
    selectedCountry.value = value;
  }
}
