import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:nectar/models/product.dart';

class ProductDetailController extends GetxController {
  String productId;
  var product = Product().obs;
  var isLoading = true.obs;
  var counter = 1.obs;
  var isProductDetailHide = false.obs;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var favourite = false.obs;
  var listFavourite = <dynamic>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getProduct();
    getFavourite();
  }

  ProductDetailController({required this.productId});

  getProduct() async {
    var data = await FirebaseFirestore.instance.collection("products").doc(productId).get();
    var temp = data.data();
    temp!.addAll({"productId": productId});
    product.value = Product.fromJson(temp);
    isLoading.value = false;
  }

  addCounter() {
    counter.value++;
  }

  removeCounter() {
    if (counter > 1) {
      counter.value--;
    }
  }

  addToCart() async {
    bool isFirstTimeAdd = true;

    var resp = await FirebaseFirestore.instance.collection("carts").doc(uid).get();
    List<dynamic> data = [];
    if (resp.data()?["products"] != null) {
      data = resp.data()?["products"];
    }
    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        if (productId == data[i]["productId"]) {
          data[i]["total"] += counter.value;
          isFirstTimeAdd = false;
        }
      }
    }
    if (isFirstTimeAdd) {
      data.add({"productId": productId, "total": counter.value});
    }

    await FirebaseFirestore.instance.collection("carts").doc(uid).set(
      {
        "products": [...data]
      },
    );
  }

  getFavourite() async {
    var resp = await FirebaseFirestore.instance.collection("favourite").doc(uid).get();
    ;
    if (resp.data()?["products"] != null) {
      listFavourite.value = resp.data()!["products"];
      for (var i = 0; i < listFavourite.length; i++) {
        if (listFavourite[i] == productId) {
          favourite.value = true;
          break;
        }
      }
    }
  }

  changeFavourite() async {
    favourite.value = !favourite.value;
    if (favourite.value) {
      listFavourite.add(productId);
      await FirebaseFirestore.instance.collection("favourite").doc(uid).set({"products": listFavourite});
    } else {
      listFavourite.remove(productId);
      if (listFavourite.isNotEmpty) {
        await FirebaseFirestore.instance.collection("favourite").doc(uid).set({"products": listFavourite});
      } else {
        await FirebaseFirestore.instance.collection("favourite").doc(uid).delete();
      }
    }
  }
}
