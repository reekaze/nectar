import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var usernameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var visibility = false.obs;
  var isEmailExist = false.obs;
  var isEmailControllerEmpty = true.obs;
  var checkEmailRegex = false.obs;

  changeVisibility() {
    visibility.value = !visibility.value;
  }

  checkEmailExistence(String email) async {
    checkEmailRegex.value = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);

    if (checkEmailRegex.value) {
      final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (list.isNotEmpty) {
        isEmailExist.value = true;
        isEmailControllerEmpty.value = false;
      } else {
        isEmailExist.value = false;
        isEmailControllerEmpty.value = false;
      }
    } else {
      isEmailControllerEmpty.value = true;
    }
  }

  signUp() {
    if (usernameController.value.text.length < 4) {
      Get.snackbar("Username length less then 4", "Please add more");
    } else if (!checkEmailRegex.value) {
      Get.snackbar("Email not valid", "Please change your email");
    } else if (isEmailExist.value) {
      Get.snackbar("Email has been taken", "Please change your email");
    } else if (passwordController.value.text.length < 6) {
      Get.snackbar("Password length less than 6", "Please add more");
    } else {
      //proceed next steps
      Get.toNamed("/phoneNumber");
    }
  }
}
