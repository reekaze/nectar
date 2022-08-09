import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var usernameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var visibility = false.obs;

  changeVisibility() {
    visibility.value = !visibility.value;
  }
}
