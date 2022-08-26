import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var username = "".obs;
  var email = FirebaseAuth.instance.currentUser!.email;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  List<List<dynamic>> listItem = [
    [Icons.shopping_bag_outlined, "Orders"],
    [Icons.badge_outlined, "My Details"],
    [Icons.place_outlined, "Delivery Address"],
    [Icons.payment_outlined, "Payment Methods"],
    [Icons.confirmation_number_outlined, "Promo Card"],
    [Icons.notifications_outlined, "Notifications"],
    [Icons.help_outline, "Help"],
    [Icons.info_outline, "About"]
  ];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    var resp = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    username.value = resp.data()!["username"];
  }
}
