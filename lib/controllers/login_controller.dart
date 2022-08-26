import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var visibility = false.obs;
  var checkEmailRegex = false.obs;

  changeVisibility() {
    visibility.value = !visibility.value;
  }

  login() async {
    checkEmailRegex.value = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(emailController.value.text);
    if (!checkEmailRegex.value) {
      Get.snackbar("Email not valid", "Please change email");
    } else if (passwordController.value.text.length < 6) {
      Get.snackbar("Password length less than 6", "Please change your password");
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.value.text, password: passwordController.value.text);
        //sucess login
        Get.offAllNamed("/home");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("user not found for that email", "please change your email");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Wrong password", "please change password");
        }
      }
    }
  }
}
