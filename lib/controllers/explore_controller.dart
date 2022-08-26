import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ExploreConroller extends GetxController {
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
}
