import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class ShopPageController extends GetxController {
  var user = <String, dynamic>{}.obs;
  var currentCarouselIndex = 0.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    user.value = data.data() as Map<String, dynamic>;
  }
}
