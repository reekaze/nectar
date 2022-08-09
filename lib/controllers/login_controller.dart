import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var visibility = false.obs;

  changeVisibility() {
    visibility.value = !visibility.value;
  }
}
