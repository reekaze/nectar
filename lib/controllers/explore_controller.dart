import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:nectar/models/product.dart';

class ExploreConroller extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    res = await FirebaseFirestore.instance.collection("products").get();
  }

  var search = TextEditingController().obs;
  var search2 = TextEditingController().obs;
  var focusNode = FocusNode().obs;
  var focusNode2 = FocusNode().obs;
  var isVisible = true.obs;
  var isVisible2 = false.obs;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var products = <Product>[].obs;
  var isLoading = true.obs;
  var res;

  List<dynamic> productTypes = [
    [
      "Fresh Fruit & Vegetables",
      "fruits_vegetables.png",
      Color(0XFF53B175),
      Color(0XFFEEF7F1),
      ["fruit", "vegetable", 'sauce']
    ],
    [
      "Noodles",
      "noodles.png",
      Color(0XFFF8A44C),
      Color(0XFFFEF6ED),
      ["noodle"]
    ],
    [
      "Meat & Fish",
      "meats_fish.png",
      Color(0XFFF7A593),
      Color(0XFFFDE8E4),
      ["meat", "fish"]
    ],
    [
      "Bakery & Snacks",
      "snacks.png",
      Color(0XFFD3B0E0),
      Color(0XFFF4EBF7),
      ["snack", "bakery"]
    ],
    [
      "Dairy & Eggs",
      "dairy_eggs.png",
      Color(0XFFFDE598),
      Color(0XFFFFF8E5),
      ["dairy", "egg"]
    ],
    [
      "Beverages",
      "beverages.png",
      Color(0XFFB7DFF5),
      Color(0XFFEDF7FC),
      ["beverages"]
    ],
  ];

  getSearchData(String text) async {
    isLoading.value = true;
    products.clear();
    if (res.docs.length > 0) {
      for (var i = 0; i < res.docs.length; i++) {
        if (res.docs[i].data()["name"].toLowerCase().contains(text.toLowerCase())) {
          Map<String, dynamic> json = res.docs[i].data();
          json.addAll({
            "productId": res.docs[i].id,
          });
          products.add(Product.fromJson(json));
        }
      }
    }
    isLoading.value = false;
  }
}
