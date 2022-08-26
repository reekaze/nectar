import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:nectar/models/product.dart';

class ExploreDetailController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  ExploreDetailController(this.listTypes);
  var listTypes = [];
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var products = <Product>[].obs;
  var isLoading = true.obs;

  getData() async {
    isLoading.value = true;
    var resp = await FirebaseFirestore.instance.collection("products").where("type", whereIn: listTypes).get();
    if (resp.docs.length > 0) {
      for (var i = 0; i < resp.docs.length; i++) {
        Map<String, dynamic> data = resp.docs[i].data();
        data.addAll({"productId": resp.docs[i].id});
        products.add(Product.fromJson(data));
      }
    }
    isLoading.value = false;
  }
}
