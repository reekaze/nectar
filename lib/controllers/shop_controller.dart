import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  var user = <String, dynamic>{}.obs;
  var exclusiveOffer = [<String, dynamic>{}].obs;
  var bestSelling = [<String, dynamic>{}].obs;
  var groceries = [<String, dynamic>{}].obs;
  var isExclusifeOfferLoading = true.obs;
  var isBestSellingLoading = true.obs;
  var isGroceriesLoading = true.obs;

  var currentCarouselIndex = 0.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getUserData();
    getExclussiveOffer();
    getBestSelling();
    getGroceries();
  }

  getUserData() async {
    var data = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    user.value = data.data() as Map<String, dynamic>;
  }

  getExclussiveOffer() async {
    var data = await FirebaseFirestore.instance.collection("products").where("tag", isEqualTo: "exclussive offer").get();
    exclusiveOffer.value = data.docs.map((data) {
      var temp = data.data();
      temp.addAll({'productId': data.id});
      return temp;
    }).toList();
    isExclusifeOfferLoading.value = false;
  }

  getBestSelling() async {
    var data = await FirebaseFirestore.instance.collection("products").where("tag", isEqualTo: "best selling").get();
    bestSelling.value = data.docs.map((data) {
      var temp = data.data();
      temp.addAll({'productId': data.id});
      return temp;
    }).toList();
    isBestSellingLoading.value = false;
  }

  getGroceries() async {
    var data = await FirebaseFirestore.instance.collection("products").where("tag", isEqualTo: "groceries").get();
    groceries.value = data.docs.map((data) {
      var temp = data.data();
      temp.addAll({'productId': data.id});
      return temp;
    }).toList();
    isGroceriesLoading.value = false;
  }
}
