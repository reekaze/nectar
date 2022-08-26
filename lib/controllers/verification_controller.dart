import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nectar/controllers/phone_number_controller.dart';

class VerificationController extends GetxController {
  var codeController = TextEditingController().obs;
  var verificationId = "".obs;
  int? resendToken;
  var pinCodeController = TextEditingController().obs;
  var isResendVisible = false.obs;
  var killTimeOut = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+${phoneNumberController.selectedCountry.value}${phoneNumberController.numberController.value.text}",
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId, "init"),
        timeout: const Duration(seconds: 60));
  }

  PhoneNumberController phoneNumberController = Get.find();

  resendOTP() async {
    isResendVisible.value = false;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+${phoneNumberController.selectedCountry.value}${phoneNumberController.numberController.value.text}",
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId, "from resend otp"),
      timeout: const Duration(seconds: 60),
      forceResendingToken: resendToken,
    );
  }

  _verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {}
  _verificationFailed(FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      Get.back();
      Get.snackbar("invalid number", "change phone number");
    }
  }

  _codeSent(String verificationId, int? resendToken) async {
    this.verificationId.value = verificationId;
    this.resendToken = resendToken;
  }

  _codeAutoRetrievalTimeout(String verificationId, String from) {
    if (!killTimeOut.value) {
      Get.snackbar("time out", "please resend code $from");
      isResendVisible.value = true;
    }
  }

  userInputtedOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: codeController.value.text);

    var x;
    try {
      x = await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
    if (x != null) {
      FirebaseAuth.instance.signOut();
      killTimeOut.value = true;
      Get.snackbar("Verify phone number success", "ok");
      Get.toNamed("/selectLocation");
    } else {
      Get.snackbar("failed", "wrong code input");
    }
  }

  changeCodeControllerValue(String value) {
    codeController.value.text = value;
  }
}
