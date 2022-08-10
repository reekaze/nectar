import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  var codeController = TextEditingController().obs;
  changeCodeControllerValue(String value) {
    codeController.value.text = value;
  }
}
