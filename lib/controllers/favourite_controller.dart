import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class FavouriteController extends GetxController {
  var listFavourite = [<String, dynamic>{}].obs;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  List<dynamic> listProducts = [];
  var listFavouriteId = [];
  var isFirstTimeAdd = true.obs;

  getData() async {
    isLoading = true.obs;
    listFavourite.value = [];
    listProducts = [];
    listFavouriteId = [];

    var resp = await FirebaseFirestore.instance.collection("favourite").doc(uid).get();

    if (resp.data()?["products"] != null && resp.data()?["products"].length > 0) {
      listFavouriteId = resp.data()!["products"];
      var respInfo = await FirebaseFirestore.instance.collection("products").where(FieldPath.documentId, whereIn: listFavouriteId).get();
      for (var i = 0; i < listFavouriteId.length; i++) {
        for (var j = 0; j < respInfo.docs.length; j++) {
          if (listFavouriteId[i] == respInfo.docs[j].id) {
            listFavourite.add(respInfo.docs[j].data());
            break;
          }
        }
      }
    }
    isLoading.value = false;
  }

  addAllToCart() async {
    var respCart = await FirebaseFirestore.instance.collection("carts").doc(uid).get();
    if (respCart.data()?["products"] != null) {
      listProducts = respCart.data()!["products"];
    }
    // inspect(respCart.data()?["products"]);
    for (var i = 0; i < listFavouriteId.length; i++) {
      isFirstTimeAdd.value = true;
      for (var j = 0; j < listProducts.length; j++) {
        if (listFavouriteId[i] == listProducts[j]["productId"]) {
          listProducts[j]["total"] += 1;
          isFirstTimeAdd.value = false;
          break;
        }
      }
      if (isFirstTimeAdd.value == true) {
        listProducts.add({
          "productId": listFavouriteId[i],
          "total": 1,
        });
      }
    }

    //update cart
    await FirebaseFirestore.instance.collection("carts").doc(uid).set({
      "products": [...listProducts]
    });
  }
}
