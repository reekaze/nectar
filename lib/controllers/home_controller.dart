import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var username = "wait".obs;
  var phone = "wait".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    inspect(data);
    username.value = data.data()!["username"];
    phone.value = data.data()!["phone"];
  }
}
